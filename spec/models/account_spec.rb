require 'rails_helper'

RSpec.describe Account, :type => :model do
  describe "Simple Validations" do
    
	it "has a valid instance of Account" do 
      expect(FactoryGirl.create(:account)).to be_valid
    end
    
    it "requires an Account number" do
      expect(FactoryGirl.build(:account,account_number: nil)).to_not be_valid
    end
  
    it "requires an Account FIDOR Id" do
      expect(FactoryGirl.build(:account,account_fidor_id: nil)).to_not be_valid
    end
	
	 it "requires a two_man_rule flag" do
      expect(FactoryGirl.build(:account,two_man_rule: nil)).to_not be_valid
    end
	
	 it "requires a customer id" do
      expect(FactoryGirl.build(:account,customer_id: nil)).to_not be_valid
    end
	
	it "requires an approver id" do
      expect(FactoryGirl.build(:account,approver_id: nil)).to_not be_valid
    end
	
  end
  
  describe " Method Validations" do
     
	it "Testing is_tmr?" do
	  account = FactoryGirl.create(:account)
      expect(account.two_man_rule).to eq(account.is_tmr?)	  
	end
  end
  
end

