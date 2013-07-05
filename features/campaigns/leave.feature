Feature: Tweeters should be able to leave a campaign
  In order to stop participating in a campaign
  As a tweeter
  I should be able to leave a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Tweeter leaves a campaign
    Given I am logged in as "rodowi"
    And I am enrolled in campaign "Experience Virgin America"
    When I go to campaign "Experience Virgin America"
    And I press "Leave"
    Then I should see "Unsubscribed successfully."

  Scenario: Guest can't leave a campaign
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Leave"

  Scenario: Agencies can't leave a campaign
    Given I am logged in as "SEMANA"
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Leave"

