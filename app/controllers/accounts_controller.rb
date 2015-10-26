class AccountsController < ApplicationController
  
  before_filter :authenticate_user
  before_action :set_account, only: [:show]
  before_action :load_oauth
  around_filter :oauth_exception, only:[:show]
  respond_to :html,:json
 
  def index
    @accounts = Account.where(:customer_id=>session[:id]).page(params[:page])
  end

  def show
    @account_detail = @client.get_account_detail(@account.account_fidor_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id]) or not_found
  end

  def oauth_exception
	begin
	  yield
	rescue ActiveRecord::RecordNotFound => error
	  flash[:error] = error.instance_values
	  respond_with @account_detail
	rescue Exceptions::OAuthConnError, Exceptions::OAuthHTTPStatusError => error
	  flash[:error] = error.instance_values
	  respond_with @account_detail
	rescue Exceptions::OAuthProcessStatusError => error
	  redirect_to logout_url, :notice => error.message
	end
  end
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params[:account]
  end

end