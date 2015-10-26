require 'faker'
FactoryGirl.define do
  factory :account do |f| 
    f.account_number { Faker::Number.number(10) }
    f.account_fidor_id '51'
	f.two_man_rule 1
	f.customer_id { Faker::Number.number(3) }
	f.approver_id { Faker::Number.number(3) }
  end

end
