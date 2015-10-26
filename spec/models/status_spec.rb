require 'rails_helper'

RSpec.describe Status, :type => :model do
  
  describe "Simple Validations" do
    it "has a valid instance of Status" do 
      expect(FactoryGirl.create(:status)).to be_valid
    end
   
    it "requires a Status Name" do
      expect(FactoryGirl.build(:status,name: nil)).to_not be_valid
    end
  end
end


