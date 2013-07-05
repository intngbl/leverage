Feature: Agency edits campaigns
  In order to update campaigns
  As an agency
  I want to be able to edit my campaigns

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns

  Scenario: Agency edits campaign
    Given I am logged in as "SEMANA"
    And Thus able to edit a campaign
    When I go to the list of SEMANA campaigns
    And I follow "Edit campaign" in row 1
    And I fill in "Brief" with "You are now ready to board."
    And I press "Update campaign"
    Then I should see "Campaign updated."
    And I should see "You are now ready to board."

