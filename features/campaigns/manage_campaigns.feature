Feature: Manage campaigns
  In order to execute better marketing
  As an agency
  I want to create and manage campaigns

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns

  Scenario: Campaigns list
    Given I am not logged in
    When I go to the list of SEMANA campaigns
    Then I should see 2 campaigns

  Scenario: Campaign show
    Given I am not logged in
    When I go to the list of SEMANA campaigns
    And I follow link in row 1
    Then I should see "Experience Virgin America"

  Scenario: Try to create campaign as a guest
    Given I am not logged in
    When I try to create a campaign for "SEMANA"
    Then "SEMANA" should have 2 campaigns

  Scenario: Try to create campaign as tweeter
    Given Tweeter rodowi exist
    And I am logged in as "rodowi"
    When I try to create a campaign for "rodowi"
    Then "rodowi" should have 0 campaigns

  Scenario: Agency creates campaign
    Given I am logged in as "SEMANA"
    And Thus able to create a Campaign
    When I follow "New campaign"
    And I fill in "Title" with "Nike at the Olympics"
    And I fill in "Brief" with "Don't dream of winning. Train for it."
    And I press "Create campaign"
    Then I should see "Campaign created."
    And I should see "Nike at the Olympics"
    And I should see "Don't dream of winning. Train for it."
    And "SEMANA" should have 3 campaigns

  Scenario: Agency edits campaign
    Given I am logged in as "SEMANA"
    And Thus able to edit a Campaign
    When I go to the list of SEMANA campaigns
    And I follow "Edit campaign" in row 1
    And I fill in "Brief" with "You are now ready to board."
    And I press "Update campaign"
    Then I should see "Campaign updated."
    And I should see "You are now ready to board."

  @javascript
  Scenario: Agency deletes campaign
    Given I am logged in as "SEMANA"
    And Thus able to delete a Campaign
    When I go to the list of SEMANA campaigns
    And "SEMANA" should have 3 campaigns
    And I follow delete link in row 1
    Then "SEMANA" should have 2 campaigns
    And I should see "Campaign deleted."
