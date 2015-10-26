# Class for instance a Direct Debit
class SepaDirectDebitDetail
 
   attr_accessor :remote_iban, :remote_bic, :mandate_id, :eref
  
  def to_s
      "<b>#{I18n.t('oauth.api.remote_iban_field')}:</b>#{@remote_iban}</br>"+
	  "<b>#{I18n.t('oauth.api.remote_bic_field')}:</b>#{@remote_bic}</br>"+
	  "<b>#{I18n.t('oauth.api.mandate_id_field')}:</b>#{@mandate_id}</br>"+
	  "<b>#{I18n.t('oauth.api.eref_field')}:</b>#{@eref}"
  end
  
end