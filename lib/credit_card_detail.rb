# Class for instance a Credit card detail
class CreditCardDetail
 
   attr_accessor :cc_merchant_name, :cc_merchant_category, :cc_type, :cc_category
  
  def to_s
	  "<b>#{I18n.t('oauth.api.cc_merchant_name_field')}:</b>#{@cc_merchant_name}</br>"+
	  "<b>#{I18n.t('oauth.api.cc_merchant_category_field')}:</b>#{@cc_merchant_category}</br>"+
	  "<b>#{I18n.t('oauth.api.cc_type_field')}:</b>#{@cc_type}</br>"+
	  "<b>#{I18n.t('oauth.api.cc_category_field')}:</b>#{@cc_category}"
  end
  
end