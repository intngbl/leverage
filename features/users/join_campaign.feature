Feature: Campaign enrollment
  In order to participate in a campaign
  As a tweeter
  I should join a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Guest can't join a campaign
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Join"

  Scenario: Tweeter joins a campaign
    Given I am logged in as "rodowi"
    When I go to campaign "Experience Virgin America"
    And I press "Join"
    Then I should see "You just joined the campaign."
    And I should be enrolled in campaign "Experience Virgin America"

  Scenario: Tweeter leaves a campaign
    Given I am logged in as "rodowi"
    And I am enrolled in campaign "Experience Virgin America"
    When I go to campaign "Experience Virgin America"
    And I press "Leave"
    Then I should see "You just left the campaign."

  Scenario: Agencies can't join campaign
    Given I am logged in as "SEMANA"
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Join"

