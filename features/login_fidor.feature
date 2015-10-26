Feature: Authentication
  In order to create Payments with CMAT
  As a user of CMAT
  I want to sign in with OAUTH Protocol 

@javascript
Scenario: Login a Valid User via Fidor OAuth
  Given I am on the login page
  When I supply the email "heinz_9807@fidortecs.de" and the password "password" 
  And I Allow the rights for CMAT
  Then I expect see the User details

@javascript
Scenario: Log out
  Given I am on the homepage
  And I follow "Sign Out" from dropdown
  Then I should see the logout page
