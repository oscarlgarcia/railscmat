require 'rails_helper'

RSpec.describe PaymentsController, :type => :controller do

  let(:valid_attributes) {
    { :account => FactoryGirl.create(:account) , :transaction_number => Faker::Number.number(3) , 
	  :amount => Faker::Number.number(3), :currency => "euro", 
	  :iban => Faker::Number.number(10), 
	  :bic => Faker::Number.number(10), :status => FactoryGirl.create(:status),
	  :uuid => Faker::Number.number(32)
	}
  }

  let(:invalid_attributes) {
    
  }

  let(:valid_session) {  
   {:token => "b536e625c91e08b734c2b976a42ad4cb",
    :access_right => "write" } 
  }

  describe "GET index" do
    it "assigns all payments as @payments" do
      payment = Payment.create! valid_attributes
      get :index, {:account_id => payment.account.id  }, valid_session
      expect(assigns(:payments)).to eq([payment])
	  expect(response).to be_success
	  expect(response).to render_template("index")
    end
  end
  
  
  describe "GET new" do
    it "assigns a new payment as @payment" do
	  account = FactoryGirl.create(:account)
      get :new, {:account_id => account.id }, valid_session
      expect(assigns(:payment)).to be_a_new(Payment)
	  expect(response).to be_success
	  expect(response).to render_template("new")
    end
  end

  describe "POST create" do
  
    describe "with valid params" do
      it "creates a new Payment" do
	    account = FactoryGirl.create(:account)
		status = FactoryGirl.create(:status)
		expect {
		post :create, {:account_id => account.id , :payment => valid_attributes}, valid_session 
		}.to change(Payment, :count).by(1)
      end
	  
	  it "call to mTan confirmation screen" do
	    payment = Payment.create! valid_attributes
	    get :mtan, {:account_id => payment.account.id, :id=>payment.id }, valid_session
	    expect(response).to be_success
	  end
	  
    end
	
	
  end
  
end
