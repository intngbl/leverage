Feature: Only owner of campaign should be able to create a tweet
  In order to publish a tweet
  As an agency
  I want to be able to create tweets for a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Agency Cooper exist
    And Tweeter rodowi exist
    And User "rodowi" is enrolled in campaign "Experience Virgin America"

  Scenario: Agency creates tweet without user assigned
    Given I am logged in as "SEMANA"
    And Thus able to create a tweet
    When I go to the list of "Experience Virgin America" tweets
    And I follow "New tweet"
    And I fill in "Body" with "Ahoy! Thou shall see this tweet"
    And I press "Schedule tweet"
    Then I should see "Tweet created"
    And I should see "Ahoy!"
    And "Experience Virgin America" should have 1 tweets

  Scenario: Agency creates tweet assigning a user
    Given I am logged in as "SEMANA"
    And Thus able to create a tweet
    When I go to the list of "Experience Virgin America" tweets
    And I follow "New tweet"
    And I fill in "Body" with "@rodowi should tweet this"
    And I select "rodowi" from "Tweeter"
    And I press "Schedule tweet"
    Then I should see "Tweet created"
    And I should see "@rodowi should tweet this"
    And "Experience Virgin America" should have 1 tweets
    And Tweet "@rodowi should tweet this" should be assigned to "rodowi"

  Scenario: Another agency attempts to create a tweet
    Given I am logged in as "Cooper"
    When I try to create a tweet for "Experience Virgin America"
    Then "Experience Virgin America" should have 0 tweets

