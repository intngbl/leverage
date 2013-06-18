Feature: Only agencies should be able to create campaigns
  In order to publish campaigns
  As an agency
  I want to be able to create campaigns

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Agency creates campaign
    Given I am logged in as "SEMANA"
    And Thus able to create a campaign
    When I follow "New campaign"
    And I fill in "Title" with "Nike at the Olympics"
    And I fill in "Brief" with "Don't dream of winning. Train for it."
    And I press "Create campaign"
    Then I should see "Campaign created."
    And I should see "Nike at the Olympics"
    And I should see "Don't dream of winning. Train for it."
    And "SEMANA" should have 3 campaigns

  Scenario: Guest attempts to create campaigns
    Given I am not logged in
    When I try to create a campaign for "SEMANA"
    Then "SEMANA" should have 2 campaigns

  Scenario: Tweeter attempts to create campaigns
    Given I am logged in as "rodowi"
    When I try to create a campaign for "rodowi"
    Then "rodowi" should have 0 campaigns

