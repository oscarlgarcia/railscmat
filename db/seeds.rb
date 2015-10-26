# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  require 'factory_girl_rails'

  10.times do
    FactoryGirl.create(:account)			 
  end
  
  # Statuses
  FactoryGirl.create(:status, name: "created")
  FactoryGirl.create(:status, name: "deleted")
  FactoryGirl.create(:status, name: "mTan_verified")
  FactoryGirl.create(:status, name: "2mc_checked")
  FactoryGirl.create(:status, name: "2mc_denied")
  FactoryGirl.create(:status, name: "completed")
  FactoryGirl.create(:status, name: "2mc_mTan_verified")
  FactoryGirl.create(:status, name: "modified")  
