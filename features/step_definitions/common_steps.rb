Given(/^I am on the homepage$/) do
   visit("/accounts")
end

Given(/^I am on the login page$/) do
   visit("/login")
end

When(/^I supply the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  fill_in('session_email', :with => email)
  fill_in('session_password', :with => password)
  click_button('Sign in')
end

When(/^I go to "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I follow "(.*?)" from dropdown$/) do |arg1|
  click_link("heinz_9807@fidortecs.de")
  click_link(arg1)
end