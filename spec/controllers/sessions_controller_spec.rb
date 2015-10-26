require 'net/http'
require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  before(:each) do
    @client = OAuth::Client.new
  end
  
  describe "index" do

	it "Get the Authorize Page" do  
	  get :create
	  expect(:create).to redirect_to(@client.authorize_url)
	end
	
  end

  describe "callback"	do

	it "Get the Error (user_denied) " do
	  get :callback , {:error => 'user_denied'}
	  expect(controller.params[:error]).to_not be_nil
	  expect(:callback).to redirect_to :logout
	end
	
	it "Get the Access Token" do
	  get :callback , {:code => Faker::Number.number(10)}
	  expect(controller.params[:code]).to_not be_nil
	  expect(session[:token]).to_not be_nil
	  expect(session[:token]).to eq('b536e625c91e08b734c2b976a42ad4cb')
	  expect(response).to redirect_to :load_user
	end
	
  end

  describe "Load User Information" do
    before do
	  session[:token] = "b536e625c91e08b734c2b976a42ad4cb"
	end
	
	it "Get User Info" do
	  get :load_user
	  expect(session[:id]).to_not be_nil
	  expect(session[:email]).to_not be_nil
	  expect(session[:access_right]).to_not be_nil
	  expect(response).to redirect_to accounts_url
	
	end
	
  end

  describe "Logout" do
    before do
      session[:token] = "b536e625c91e08b734c2b976a42ad4cb"
    end
  
    it "Performs Logout" do
      get :destroy
	  expect(session[:token]).to be_nil
      expect(session[:id]).to be_nil
	  expect(session[:email]).to be_nil
	  expect(session[:access_right]).to be_nil
	  expect(response).to render_template :logout
    end  

  end

end