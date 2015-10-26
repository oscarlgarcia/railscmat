class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  
  protected 
  
  # Prevent for not logged Users to execute protected actions
  def authenticate_user
    if session[:token]
      return true	
    else
      redirect_to login_url
      return false
    end
  end
  
  def payment_permissions?
    if session[:access_right] == "write"  #TODO poner en constant
	  return true
	else
	  redirect_to accounts_url
      return false	
	end
  end
  
  #Prevents a Logged User execute the login proccess again
  def save_login_state
    if session[:token]
	  #o al controlador de las cuentas
      redirect_to accounts_url
      return false
    else
      return true
    end
  end
  
  # Set the locale from parameters
  def set_locale
    I18n.locale = params[:locale] unless params[:locale].blank?
  end
  
  #Load the OAuth
  def load_oauth
	  @client= OAuth::Client.new(session[:token]) #TODO quitar de instance por scope
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_error exception.message
  end
  
  def render_error(status)
    flash[:status] = status #request.path
    render template: 'four_o_four/index'
  end
  
  
end
