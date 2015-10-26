class TransactionsController < ApplicationController

  before_filter :authenticate_user
  before_action :set_account
  before_action :load_oauth
  around_filter :oauth_exception
   
  def index
    @operation = @client.get_transactions(@account.account_fidor_id,params[:page],params[:start_date],params[:end_date],params[:per_page])
	@transactions = Kaminari.paginate_array(@operation.result,total_count: @operation.pagination.total_entries)
	                  .page(@operation.pagination.current_page)
					  .per(@operation.pagination.per_page)
    respond_to do |format|
      format.html
      format.csv { send_data Transaction.to_csv(@operation.result) }
	end
  end

  
  private 
  def set_account
    @account = Account.find(params[:account_id])
  end

  def oauth_exception
    begin
	  yield
	rescue Exceptions::OAuthConnError, Exceptions::OAuthHTTPStatusError => error
	  flash[:error] = error.instance_values
	  respond_to do |format|
      format.html
      format.csv 
	end
	rescue Exceptions::OAuthProcessStatusError => error
	  redirect_to logout_url, :notice => error.message
    end
  end
	
end
