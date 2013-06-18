Feature: Only agencies should be able to create campaigns
  In order to know that I successfully removed a campaign
  As an agency
  I want to be told that a campaign was deleted

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns

  @javascript
  Scenario: Agency deletes campaign
    Given I am logged in as "SEMANA"
    And Thus able to delete a campaign
    When I go to the list of SEMANA campaigns
    And "SEMANA" should have 2 campaigns
    And I follow delete link in row 1
    Then I should see "Campaign deleted."
    And "SEMANA" should have 1 campaigns

