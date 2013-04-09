Feature: Social Connect
As an unauthorized user
I want to signin with my socials acount
So that I can login

Scenario Outline: Sign in
  Given I am on the home page
  And I should see "Sign in with <provider>"
  When I follow "Sign in with <provider>"
  Then I should see "Successfully authenticated from <provider> account."

  Examples:
    |provider|
    |Twitter|
    |Google|
