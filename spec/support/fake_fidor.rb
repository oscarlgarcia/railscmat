require 'sinatra/base'

class FakeFidor < Sinatra::Base

  # OAUTH Autorize_url Fake
  get '/oauth/authorize' do
    redirect "http://localhost:3000/callback?code=12345", 200
  end
  
  post '/oauth/token' do
    json_response 200, 'token.json'
  end
  
  get '/users/current' do
    json_response 200, 'user_current.json'
  end

  get '/accounts/:id' do
    json_response 200, 'account.json'
  end
  
  get '/accounts/:id/transactions' do
    json_response 200, 'transactions.json'
  end
  
  private

  def json_response(response_code, file_name)
    content_type :json
	headers['x-total'] = 20
	headers['x-limit'] = 10
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
  
  def html_response(response_code, file_name)
    content_type :html
    status response_code
    send_file File.dirname(__FILE__) + '/fixtures/' + file_name
  end
  
  
end