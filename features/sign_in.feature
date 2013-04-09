Feature: Sign un
As an exiting user
I want to sign in with my credentials
So that I can login

Scenario: User signs in successfully with username
  Given I am a registered user
  When I go to the login page
  And I fill in username "lio10" and password "12345678"
  When I press "Sign in"
  Then I should see "Signed in successfully."