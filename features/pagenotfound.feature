Feature: Page not Found
  As a user of CMAT
  I cannot request an non existent resource

Scenario: Page not Found
  Given I am on the homepage
  When I request a non existent resource
  Then I expect see the 404 page