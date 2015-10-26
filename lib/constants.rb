module Constants  
  
  #OAuth Settings

  OAUTH_CALLBACK_URL         = 'http://localhost:3000/callback' 
  OAUTH_CLIENT_ID            = 'aff4e4b382830161'
  OAUTH_CLIENT_SECRET        = '1de63ecf9dbfff930b8dd79fcd8ece5c'
  OAUTH_REPONSE_TYPE         = 'code'  
  OAUTH_STATE                = '534'
  OAUTH_AUTHCODE             = 'authorization_code'
  OAUTH_AUTHORIZE_URL        = 'http://aps.test.fidor.de/oauth/authorize'  
  OAUTH_TOKEN_URL            = 'http://aps.test.fidor.de/oauth/token'
  OAUTH_ERRCONN_CLASS        = 'OAuthConnError'
  OAUTH_ERRHTTPSTATUS_CLASS  = 'OAuthHTTPStatusError'
  OAUTH_ERRPROCESS_CLASS     = 'OAuthProcessStatusError' 
   
  #API URL
  API_CURRENTUSER_URL        = 'http://aps.test.fidor.de/users/current' 
  API_ACCOUNTS_URL           = 'http://aps.test.fidor.de/accounts/' 
  API_TRANSACTIONS_URL       = 'transactions'
  API_CREDIT_TRANSFER_URL    = 'http://aps.test.fidor.de/sepa_credit_transfers'
   
  #API Parameters
  API_CLIENTID_PARAM         = 'client_id'
  API_REDIRECTURI_PARAM      = 'redirect_uri'
  API_CODE_PARAM             = 'code'
  API_CLIENTSECRET_PARAM     = 'client_secret'
  API_GRANTTYPE_PARAM        = 'grant_type'
  API_STATE_PARAM            = 'state'
  API_RESPONSETYPE_PARAM     = 'response_type'
  API_ACCESSTOKEN_PARAM      = 'access_token'
  API_ERROR_PARAM            = 'error'
  API_PAGE_PARAM             = 'page'
  API_BOOKING_DATE_FROM_PARAM = 'filter[booking_date_from]'
  API_BOOKING_DATE_TO_PARAM  = 'filter[booking_date_to]'
  API_PER_PAGE_PARAM         = 'per_page'
  API_ACCOUNTID_PARAM        = 'account_id'
  API_UUID_PARAM             = 'external_uid'
  API_REMOTE_IBAN_ID_PARAM   = 'remote_iban'
  API_REMOTE_BIC_PARAM       = 'remote_bic'
  API_REMOTE_NAME_PARAM      = 'remote_name'
  API_AMOUNT_PARAM           = 'amount'
  API_SUBJECT_PARAM          = 'subject'
  API_CONTENT_TYPE_PARAM     = 'Content-Type'
  API_CONTENT_JSON_PARAM     = 'application/json'
  API_CONTENT_FORM_PARAM     = 'application/x-www-form-urlencoded'
  
  #API read fields
  API_ID_FIELD               = 'id'
  API_USEREMAIL_FIELD        = 'email'
  API_USERACCESSRIGHT_FIELD  = 'access_right'
  API_ERROR_FIELD            = 'error'
  API_CODE_FIELD             = 'code'
  API_MESSAGE_FIELD          = 'message'
  API_ERRORS_FIELD           = 'errors'
  API_ACCOUNTNUMBER_FIELD    = 'account_number'
  API_BALANCE_FIELD          = 'balance'
  API_BALANCEAVAILABLE_FIELD = 'balance_available'
  API_IBAN_FIELD             = 'iban'
  API_ACCOUNTID_FIELD        = 'account_id'
  API_TRANSACTIONTYPE_FIELD  = 'transaction_type'
  API_SUBJECT_FIELD          = 'subject'
  API_AMOUNT_FIELD           = 'amount'
  API_CURRENCY_FIELD         = 'currency'
  API_BOOKINGDATE_FIELD      = 'booking_date'
  API_VALUEDATE_FIELD        = 'value_date'
  API_RETURN_TRANS_ID_FIELD  = 'return_transaction_id'
  API_CREATEDAT_FIELD        = 'created_at'
  API_UPDATEDAT_FIELD        = 'updated_at'
  API_TRANS_TYPE_DETAILS_FIELD = 'transaction_type_details'
  API_SEPA_CREDIT_TRANS_ID_FIELD = 'sepa_credit_transfer_id'
  API_REMOTE_NAME_FIELD      = 'remote_name'
  API_REMOTE_IBAN_ID_FIELD   = 'remote_iban'
  API_REMOTE_BIC_FIELD       = 'remote_bic'
  API_REMOTE_ACCOUNT_ID_FIELD = 'remote_account_id'
  API_INTERNAL_TRANSFER_ID_FIELD = 'internal_transfer_id'
  API_MANDATE_ID_FIELD       = 'mandate_id'
  API_EREF_FIELD             = 'eref'
  API_CC_MERCHANT_NAME_FIELD = 'cc_merchant_name'
  API_CC_MERCHANT_CAT_FIELD  = 'cc_merchant_category'
  API_CC_TYPE_FIELD          = 'cc_type'
  API_CC_CATEGORY_FIELD      = 'cc_category'
  
  #API Pagination Fields
  API_LIMIT_HEADER_FIELD     = 'x-limit'
  API_TOTAL_HEADER_FIELD     = 'x-total'
   
  #API Pagination settings
  API_START_DATE             = ''
  API_END_DATE               = ''
  API_PER_PAGE               = 10
  API_CURRENT                = 1 
  API_DATE_FORMAT            = '%Y-%m-%d'
  API_DATE_DEFAULT_FRAME     = 7.days
   
   
  #TRANSACTION SETTINGS

  #Transaction Type Details map    
   TRANSACTION_TYPE_ARRAY    = {'payin_fidorpay' => 'InternalTransferDetail',
                                'payout_fidorpay' => 'InternalTransferDetail',
                                'payin_credit_note_sepa' => 'SepaCreditTransferDetail',
							                  'payout_credit_note_sepa' => 'SepaCreditTransferDetail',
							                  'payout_creditcard' => 'CreditCardDetail',
                                'payin_giropay' => 'InternalTransferDetail',
								                'payin_paymentnetwork' => 'InternalTransferDetail',
								                'payin_credit_note' => 'InternalTransferDetail',
                                'payin_debit_note_eze' => 'InternalTransferDetail',
                                'payin_debit_note_aba' => 'InternalTransferDetail',
                                'payin_debit_note_sepa_core' => 'InternalTransferDetail',
                                'payin_debit_note_sepa_b2b' => 'InternalTransferDetail',
                                'payout_ogone' => 'InternalTransferDetail',
                                'payout_paymentnetwork' => 'InternalTransferDetail',
                                'payout_credit_note' => 'InternalTransferDetail',
                                'payout_debit_note_eze' => 'InternalTransferDetail',
                                'payout_fee' => 'InternalTransferDetail'
                               }
	
  #Payment Settings
  PAYMENT_CREATED_STATUS            = 'created'
  PAYMENT_MTANCONFIRMED_STATUS      = 'mTan_verified'
  PAYMENT_2MC_CHECKED_STATUS        = '2mc_checked'
  PAYMENT_COMPLETED_STATUS          = 'completed' 
  PAYMENT_2MC_DENIED_STATUS         = '2mc_denied'
  PAYMENT_MODIFIED_STATUS           = 'modified'
  PAYMENT_2MC_MTANCONFIRMED_STATUS  = '2mc_mTan_verified'
end