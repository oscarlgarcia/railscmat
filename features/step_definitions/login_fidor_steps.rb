
When(/^I Allow the rights for CMAT$/) do 
  click_button('Allow')
end

Then(/^I expect see the User details$/) do
  expect(page).to have_content("heinz_9807@fidortecs.de")
end

Then(/^I should see the logout page$/) do
  expect(page).to have_content("Please proceed to Login with your Fidor account")
end