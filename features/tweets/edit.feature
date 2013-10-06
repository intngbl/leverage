Feature: Agency edits tweets
  In order to adjust a campaign
  As an agency
  I want to be able to edit my tweets

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Campaign "Experience Virgin America" has 1 tweet

  Scenario: Agency edits campaign
    Given I am logged in as "SEMANA"
    And Thus able to edit a campaign
    When I go to the list of "Experience Virgin America" tweets
    And I follow "Edit" in row 1
    And I fill in "Body" with "You are now ready to board."
    And I press "Update"
    Then I should see "Tweet updated"
    And I should see "You are now ready to board."

