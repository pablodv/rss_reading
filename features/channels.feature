Feature: Channel Management & Display
  In order to make my readers
  As a singed in user
  I need to be able to manage my channels

  Background: Login User
    Given the following user record
      | username |
      | testuser |
    Given I am logged in as "testuser" with password "12345678"

  Scenario: Channels List
    Given I have channels named RailsCasts, Tender Lovemaking
    When I go to the list of channels
    Then I should see "RailsCasts"
    And I should see "Tender Lovemaking"

  Scenario: Create Valid Channel
    Given I have no channels
    When I go to the list of channels
    When I follow "Add Feed"
    And I fill in "Url" with "http://feeds.feedburner.com/railscasts"
    And I press "Save Channel"
    Then I should see "Channel was successfully created."
    And I should see "RailsCasts"
    And I should have 1 channel

  Scenario: Destroy Channel
    Given I have channels named RailsCasts
    When I go to the list of channels
    And I follow "Remove"
    Then I should see "Channel was successfully deleted."
    And I should not see "RailsCasts"
