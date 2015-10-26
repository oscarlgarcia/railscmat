Feature: Listing Accounts
  In order to create Payments with CMAT
  As a user of CMAT
  I want to list all of the available accounts

Background:
  Given I am on the login page
  When I supply the email "heinz_9807@fidortecs.de" and the password "password"   
  
@javascript
Scenario: List all accounts
  Given I follow "Accounts" from dropdown
  Then I expect see the Accounts details  