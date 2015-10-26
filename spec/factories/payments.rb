FactoryGirl.define do
  factory :payment do |f| 
    account
	f.transaction_number { Faker::Number.number(3) }
	f.amount { Faker::Number.number(3) }
	f.currency "EUR"
	f.iban "DEXXXX0740755844307784"
	f.bic "NL14ABNA031228YYYY"
	f.uuid { Faker::Number.number(32) }
	f.name { Faker::Name.name }
	status
  end

end
