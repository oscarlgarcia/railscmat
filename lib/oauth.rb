require 'net/http'

module OAuth
  
  class Client
  
    attr_reader :token
	
    def initialize(token = '')
      @token  =  token
    end
    
    def authorize_url
     url = "#{Constants::OAUTH_AUTHORIZE_URL}?#{Constants::API_CLIENTID_PARAM}=#{Constants::OAUTH_CLIENT_ID}&#{Constants::API_REDIRECTURI_PARAM}=#{CGI::escape(Constants::OAUTH_CALLBACK_URL)}&#{Constants::API_STATE_PARAM}=#{Constants::OAUTH_STATE}&#{Constants::API_RESPONSETYPE_PARAM}=#{Constants::OAUTH_REPONSE_TYPE}"
    end

	def get_access_token (code = '0')
	  response = post_call(Constants::OAUTH_TOKEN_URL,
                   {
				     Constants::API_CLIENTID_PARAM => Constants::OAUTH_CLIENT_ID,
                     Constants::API_REDIRECTURI_PARAM => CGI::escape(Constants::OAUTH_CALLBACK_URL),
                     Constants::API_CODE_PARAM =>code,
                     Constants::API_CLIENTSECRET_PARAM=>Constants::OAUTH_CLIENT_SECRET ,
                     Constants::API_GRANTTYPE_PARAM=>Constants::OAUTH_AUTHCODE
			       }, 
			       Constants::API_CONTENT_FORM_PARAM
			 )
	  body = ActiveSupport::JSON.decode(response.body)
	  @token = body[Constants::API_ACCESSTOKEN_PARAM]	
	end
	
	def get_current_user
	  response = get_call(Constants::API_CURRENTUSER_URL,{Constants::API_ACCESSTOKEN_PARAM =>@token})
	  body = ActiveSupport::JSON.decode(response.body)
	  user = User.new(body[Constants::API_ID_FIELD],
	           body[Constants::API_USEREMAIL_FIELD],
			   body[Constants::API_USERACCESSRIGHT_FIELD]
			 )
	end
	
	def get_account_detail (account_id)
	  response = get_call("#{Constants::API_ACCOUNTS_URL}#{account_id}",{Constants::API_ACCESSTOKEN_PARAM =>@token})
	  body = ActiveSupport::JSON.decode(response.body)
	  account_info = AccountDetail.new(body[Constants::API_ID_FIELD],
	                   body[Constants::API_ACCOUNTNUMBER_FIELD],
					   body[Constants::API_BALANCE_FIELD],
					   body[Constants::API_BALANCEAVAILABLE_FIELD],
					   body[Constants::API_IBAN_FIELD]
					 )
	end
	
	def get_transactions(account_id, current = Constants::API_CURRENT, start_date = nil, end_date = nil, per_page = Constants::API_PER_PAGE)
	  current = Constants::API_CURRENT if current.nil?
	  per_page = Constants::API_PER_PAGE if per_page.nil?
	  start_date =(Time.now - Constants::API_DATE_DEFAULT_FRAME).strftime(Constants::API_DATE_FORMAT) if start_date.nil?
	  end_date = Time.now.strftime(Constants::API_DATE_FORMAT) if end_date.nil?
	  
	  response = get_call("#{Constants::API_ACCOUNTS_URL}#{account_id}/#{Constants::API_TRANSACTIONS_URL}",
	               {
			         Constants::API_ACCESSTOKEN_PARAM =>@token,
	                 Constants::API_PAGE_PARAM => current, 
			         Constants::API_BOOKING_DATE_FROM_PARAM => start_date,
			         Constants::API_BOOKING_DATE_TO_PARAM => end_date,
			         Constants::API_PER_PAGE_PARAM => per_page
			       }
			     )  
	  body = ActiveSupport::JSON.decode(response.body)
	  limit = response[Constants::API_LIMIT_HEADER_FIELD].to_i
	  total_result = response[Constants::API_TOTAL_HEADER_FIELD].to_i
	  total_pages = ( (total_result % limit) == 0 ) ? (total_result / limit) : ((total_result / limit) + 1)
	  pagination = Pagination.new(per_page.to_i,
	                 current.to_i,
					 limit,
					 total_result,
					 total_pages
				   )
  
	  transactions = Array.new(pagination.total_entries)
	  body.each_with_index do |data, index|
	    transaction = Transaction.new
	    transaction.id = data[Constants::API_ID_FIELD]
		transaction.account_number = data[Constants::API_ACCOUNTID_FIELD]
		transaction.transaction_type = data[Constants::API_TRANSACTIONTYPE_FIELD]
		transaction.subject = data[Constants::API_SUBJECT_FIELD]
		transaction.amount = data[Constants::API_AMOUNT_FIELD]
		transaction.currency = data[Constants::API_CURRENCY_FIELD]
		transaction.booking_date = data[Constants::API_BOOKINGDATE_FIELD]
		transaction.value_date = data[Constants::API_VALUEDATE_FIELD]
		transaction.return_transaction_id = data[Constants::API_RETURN_TRANS_ID_FIELD]
		transaction.created_at = data[Constants::API_CREATEDAT_FIELD]
		transaction.updated_at = data[Constants::API_UPDATEDAT_FIELD]
		details = data[Constants::API_TRANS_TYPE_DETAILS_FIELD]
		transaction.transaction_type_details = transaction_type_details(transaction.transaction_type,details)
		transactions[index+(pagination.per_page*(pagination.current_page-1))] = transaction
	  end
	  
	  operation = Operation.new(transactions,pagination)
	end
	
	def post_payment(payment)
	  response = post_call("#{Constants::API_CREDIT_TRANSFER_URL}?#{Constants::API_ACCESSTOKEN_PARAM}=#{@token}",
                   {
                     Constants::API_ACCOUNTID_PARAM =>payment.account.account_fidor_id,
				     Constants::API_UUID_PARAM =>payment.uuid,
				     Constants::API_REMOTE_IBAN_ID_PARAM =>payment.iban,
				     Constants::API_REMOTE_BIC_PARAM =>payment.bic, 
					 Constants::API_REMOTE_NAME_PARAM =>payment.name,
				     Constants::API_AMOUNT_PARAM =>payment.amount,
				     Constants::API_SUBJECT_PARAM =>payment.txt_reference
				   }
				 )            
      body = ActiveSupport::JSON.decode(response.body)
      return body[Constants::API_ID_FIELD]	  
	  
	end

    def request_mtan(payment)
    	#TODO request the MTAN
        Rails.logger.error {"************** Called to Request MTAN *********************"}
    	return "112233" #return a class containin the ID of the request and the status
    end

	def mtan_valid?(mtan = 'XX')
	  Rails.logger.error {"************** Called to Validate MTAN *********************"}
	  #TODO MTAN API call here
	  return true

	end
	
		
	private	

	def get_call (url,params)
	  uri = URI(url)
      begin
	    uri.query = URI.encode_www_form(params)
	    response = Net::HTTP.get_response(uri)
		
		case response.code
		  when '200' # Ok
		    return response
		  when '404' # Notfound
		    raise_error(I18n.t('errors.oauth.httpStatus_error') + response.message,Constants::OAUTH_ERRHTTPSTATUS_CLASS,
			   response.code,
			   response.message,
			   ''
			)  
		  when '400' # invalid params name
		    raise_error(I18n.t('errors.oauth.httpStatus_error') + response.message,Constants::OAUTH_ERRHTTPSTATUS_CLASS,
			   response.code,
			   response.message,
			   ''
			)
		  else # the service return an API logic error  ( invalid token, unknow entity,etc)
			body=ActiveSupport::JSON.decode(response.body)[Constants::API_ERROR_FIELD ]
			raise_error(I18n.t('errors.oauth.processStatus_error') + url + ":#{body[Constants::API_ERROR_FIELD]}",
			  Constants::OAUTH_ERRPROCESS_CLASS,
			  body[Constants::API_CODE_FIELD],
			  body[Constants::API_MESSAGE_FIELD],
			  body[Constants::API_ERRORS_FIELD]
			)
	      end

	  rescue SocketError, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
		raise_error(I18n.t('errors.oauth.GET_conn_error') + e.message,Constants::OAUTH_ERRCONN_CLASS)
	  end
	end
	
	def post_call(url,params,content_type = Constants::API_CONTENT_JSON_PARAM) 
	  uri = URI(url)
	  begin
	  
	    request = Net::HTTP::Post.new(uri.to_s,initheader = {Constants::API_CONTENT_TYPE_PARAM =>content_type})
	    
		if content_type == Constants::API_CONTENT_JSON_PARAM
		  request.body = JSON.generate(params)
		else
		  request.body = URI.encode_www_form(params)
		end
		
        response = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(request)
        end

		case response.code
		  when '200' # Ok
		    return response
		  when '404' # Notfound
		    raise_error(I18n.t('errors.oauth.httpStatus_error') + response.message,Constants::OAUTH_ERRHTTPSTATUS_CLASS,
			  response.code,
			  response.message,
			  ''
			)  
		  when '400' # invalid params name
		    raise_error(I18n.t('errors.oauth.httpStatus_error') + response.message,Constants::OAUTH_ERRHTTPSTATUS_CLASS,
			  response.code,
			  response.message,
			  ''
			)  
		  else # the service return an API logic error  ( invalid token, etc)
		    body=ActiveSupport::JSON.decode(response.body)
			raise_error(I18n.t('errors.oauth.processStatus_error') + url + ":#{body[Constants::API_ERROR_FIELD]}",
			  Constants::OAUTH_ERRPROCESS_CLASS,body[Constants::API_CODE_FIELD],
			  body[Constants::API_MESSAGE_FIELD],
			  body[Constants::API_ERRORS_FIELD]
			)
		end
		
	  rescue SocketError,Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
	    raise_error( I18n.t('errors.oauth.POST_conn_error') + e.message,Constants::OAUTH_ERRCONN_CLASS)
	  end
	
	end
	
	def transaction_type_details(transaction_type, details)
	  object = Constants::TRANSACTION_TYPE_ARRAY[transaction_type].constantize.new
	  
	  case object
	    when InternalTransferDetail
		  object.remote_account_id = details[Constants::API_REMOTE_ACCOUNT_ID_FIELD]
          object.internal_transfer_id = details[Constants::API_INTERNAL_TRANSFER_ID_FIELD]
		
		when SepaCreditTransferDetail
		  object.sepa_credit_transfer_id = details[Constants::API_SEPA_CREDIT_TRANS_ID_FIELD]
		  object.remote_name = details[Constants::API_REMOTE_NAME_FIELD]
		  object.remote_iban = details[Constants::API_REMOTE_IBAN_ID_FIELD]
		  object.remote_bic = details[Constants::API_REMOTE_BIC_FIELD]
		  
		when SepaDirectDebitDetail
	     object.remote_iban = details[Constants::API_REMOTE_IBAN_ID_FIELD]
		 object.remote_bic = details[Constants::API_REMOTE_BIC_FIELD]
		 object.mandate_id = details[Constants::API_MANDATE_ID_FIELD]
		 object.eref = details[Constants::API_EREF_FIELD]
		 
		else  #creditcard
		  object.cc_merchant_name = details[Constants::API_CC_MERCHANT_NAME_FIELD]
		  object.cc_merchant_category = details[Constants::API_CC_MERCHANT_CAT_FIELD]
		  object.cc_type = details[Constants::API_CC_TYPE_FIELD]
	      object.cc_category = details[Constants::API_CC_CATEGORY_FIELD]
	  end
	  
	  return object
	  
	end
	
	def raise_error (logMsg,errorType,code = '',msg = '',errors = '')	  
	  Rails.logger.error {"#{logMsg}"}
	  raise "Exceptions::#{errorType}".constantize.new(code,msg,errors)
	end
	
  end	
  
end