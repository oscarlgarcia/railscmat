Then(/^I expect see the Accounts details$/) do
  accounts = Account.all  
  expect(accounts.size).to eq(2)
  accounts.each do |account|
    expect(page).to have_content(account.account_number)
  end
end