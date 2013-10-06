Feature: Only agencies should be able to delete their tweets
  In order to know that I successfully removed a tweet
  As an agency
  I want to be told that a tweet was deleted

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Campaign "Experience Virgin America" has 2 tweets

  @javascript
  Scenario: Agency deletes tweet
    Given I am logged in as "SEMANA"
    And Thus able to delete a tweet
    And I go to the list of "Experience Virgin America" tweets
    And "Experience Virgin America" should have 2 tweet
    When I follow delete link in row 1 column 7
    Then I should see "Tweet deleted"
    And "Experience Virgin America" should have 1 tweet

