Feature: Channel Management & Display
  In order to add channels
  As a singed in user
  I need to be able to manage my channels

  Scenario: Show Channel
    Given I have a channel
    And my channel has name "My channel"
    When I display the channel
    Then i should see "My channel"