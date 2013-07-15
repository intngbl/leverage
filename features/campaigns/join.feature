Feature: Tweeters should be able to join a campaign
  In order to participate in a campaign
  As a tweeter
  I should be able to join a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Tweeter joins a campaign
    Given I am logged in as "rodowi"
    When I go to campaign "Experience Virgin America"
    And I press "Join"
    Then I should see t("campaigns.join.request")
    And I should be enrolled in campaign "Experience Virgin America"

  Scenario: Tweeter should see his/her pending enrollment
    Given I am logged in as "rodowi"
    And I am enrolled in campaign "Experience Virgin America"
    When I follow "Joined campaigns"
    Then I should see "Virgin America"
    And I should see "waiting for approval"

  Scenario: Guest can't join a campaign
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Join"

  Scenario: Agencies can't join campaign
    Given I am logged in as "SEMANA"
    When I go to campaign "Experience Virgin America"
    Then I should not see button "Join"

