
When(/^I request a non existent resource$/) do
  visit("/nonexistent")
end

Then(/^I expect see the (\d+) page$/) do |arg1|
  expect(page).to have_content("This page cannot be found")
end 