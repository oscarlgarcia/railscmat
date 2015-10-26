require 'rails_helper'

RSpec.describe Payment, :type => :model do
  
  describe "Simple Validations" do
   
    it "has a valid instance of Payment" do 
      expect(FactoryGirl.create(:payment)).to be_valid
    end 
  
    it "requires an Account" do
      expect(FactoryGirl.build(:payment,account_id: nil)).to_not be_valid
    end
	
	  it "requires a Transaction number" do
      expect(FactoryGirl.build(:payment,transaction_number: nil)).to_not be_valid
    end
	
    it "requires an Amount" do
      expect(FactoryGirl.build(:payment,amount: nil)).to_not be_valid
    end
    
    it "requires a Currency" do
      expect(FactoryGirl.build(:payment,currency: nil)).to_not be_valid
    end
	
	  it "requires IBAN" do
      expect(FactoryGirl.build(:payment,iban: nil)).to_not be_valid
    end
	
	  it "requires BIC" do
      expect(FactoryGirl.build(:payment,bic: nil)).to_not be_valid
    end
	
	  it "requires a Status" do
      expect(FactoryGirl.build(:payment,status_id: nil)).to_not be_valid
    end
	
	  it "requires a UUID" do
      expect(FactoryGirl.build(:payment,uuid: nil)).to_not be_valid
    end

    it "Remote Name does not required" do
      expect( FactoryGirl.build(:payment,name: nil)).to be_valid
    end


  end 

end
