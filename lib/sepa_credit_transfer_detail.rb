# Class for instance a Transaction
class SepaCreditTransferDetail
 
   attr_accessor :sepa_credit_transfer_id, :remote_name, :remote_iban, :remote_bic
  
  def to_s
      "<b>#{I18n.t('oauth.api.remote_name_field')}:</b>#{@remote_name}</br>"+
	  "<b>#{I18n.t('oauth.api.remote_iban_field')}:</b>#{@remote_iban}</br>"+
	  "<b>#{I18n.t('oauth.api.remote_bic_field')}:</b>#{@remote_bic}"
  end
  
end