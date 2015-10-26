class SessionsController < ApplicationController
  
  before_filter :authenticate_user, only: [:load_user]
  before_filter :save_login_state, only: [:create, :callback]
  around_filter :oauth_exception, only: [:callback, :load_user]
  before_action :load_oauth
  layout "logout", only: [:destroy]

  def create
    redirect_to @client.authorize_url
  end
  
  def callback

    if params[:error]
     redirect_to logout_url  , :notice =>t('views.session.logout.user_doesnot_grant_app') and return
    end
      
	if params[:code]
	  token = @client.get_access_token(params[:code]) 
    else
	  redirect_to @client.authorize_url and return
	end  

    session[:token] = token
	redirect_to :action =>:load_user and return	
	
  end
  
  def load_user 
	user = @client.get_current_user()
	session[:id] =   user.id # '535' #
	session[:email] = user.email
	session[:access_right] = "write"#user.access_right
	redirect_to accounts_url and return

  end  
  
  def destroy
    @notice = flash[:notice] 
    reset_session
	render :logout
  end
  
  private
  
  def oauth_exception
    begin
	  yield
	rescue Exceptions::OAuthConnError, Exceptions::OAuthHTTPStatusError, Exceptions::OAuthProcessStatusError => error
	  redirect_to logout_url  , :notice => t('views.session.logout.connectivity_problems') and return
	end
  end

end