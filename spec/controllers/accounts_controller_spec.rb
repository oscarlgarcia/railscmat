require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do
  
  let(:valid_attributes) {
    { :account_number => Faker::Number.number(10), :account_fidor_id =>'51',
	  :two_man_rule => 1, :customer_id => 534 , :approver_id => 534}
  }
  
  let(:valid_session) {  
   {:token => "b536e625c91e08b734c2b976a42ad4cb",
    :id => 534} 
  }
  
  before(:each) do
    @client = OAuth::Client.new
  end

  describe "GET index" do
  
	it "load all Accounts for this user" do
	  account = Account.create! valid_attributes
	  get :index, {}, valid_session
	  expect(assigns(:accounts)).to eq([account])
	  expect(response).to be_success
	  expect(response).to render_template("index")
	end
	
  end
  
  describe "GET show" do
	
	it "show Account details" do
	  account = Account.create! valid_attributes
	  get :show, {:id => account.id}, valid_session
	  expect(assigns(:account)).to eq(account)
	  expect(assigns(@account_detail)).to_not be_nil
	  expect(response).to be_success
	  expect(response).to render_template("show")
	end

  end
  
end