Feature: Only owner of campaign should be able to create a tweet
  In order to publish a tweet
  As an agency
  I want to be able to create tweets for a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Agency Cooper exist

  Scenario: Agency creates campaign
    Given I am logged in as "SEMANA"
    And Thus able to create a tweet
    When I go to the list of "Experience Virgin America" tweets
    And I follow "New tweet"
    And I fill in "Body" with "Ahoy! Thou shall see this tweet"
    And I press "Schedule tweet"
    Then I should see "Tweet created"
    And I should see "Ahoy!"
    And "Experience Virgin America" should have 1 tweets

  Scenario: Another agency attempts to create a tweet
    Given I am logged in as "Cooper"
    When I try to create a tweet for "Experience Virgin America"
    Then "Experience Virgin America" should have 0 tweets

