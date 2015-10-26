# Class for instance a Internal Transfer
class InternalTransferDetail
 
   attr_accessor :remote_account_id, :internal_transfer_id
   
  def to_s  
	  "<b>#{I18n.t('oauth.api.remote_account_id_field')}:</b>#{@remote_account_id}</br>"+
	  "<b>#{I18n.t('oauth.api.internal_transfer_id_field')}:</b>#{@internal_transfer_id}"
  end
  
end