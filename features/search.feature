Feature: Search
  As a User
  I want to search for content
  In order to find content easily over paginating

  Background:
   Given I am on the home page

  Scenario: Find channel by content
    Given the following channel:
      | title             |
      | Demon in a Bottle |
      | Extremis          |
    When I search for "Demon"
    Then I should be on the search page
    And I should see the channel called "Demon in a Bottle" in the channel list
    But I should not see the channel called "Extremis" in the channel list
