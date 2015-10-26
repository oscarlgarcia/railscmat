require 'rails_helper'

RSpec.describe TransactionsController, :type => :controller do

  let(:valid_session) {  
   {:token => "b536e625c91e08b734c2b976a42ad4cb"} 
  }

  before(:each) do
    @client = OAuth::Client.new
  end
  
  describe "GET index" do
    let!(:my_account) { FactoryGirl.create(:account) }
	
	it "get All Transactions" do
	  get :index, {:account_id => my_account.id}, valid_session
	  expect(assigns(:transactions)).to_not be_nil
	  expect(response).to be_success
	  expect(response).to render_template("index")
	end
	
  end





end
