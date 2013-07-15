Feature: Show campaign details
  In order to see what a campaign has to offer
  As a regular user or guest
  I want to be able to see a details of a campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist
    And User "rodowi" is enrolled in campaign "Experience Virgin America"

  Scenario: Anyone is able to see campaign details
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should see "Experience Virgin America"

  Scenario: Agency can see joined users of a campaign
    Given I am logged in as "SEMANA"
    When I go to campaign "Experience Virgin America"
    And I follow "1 user have joined"
    Then I should see "rodowi"
    And I should see button "Accept"
    And I should see button "Decline"

  Scenario: Guest is not allowed to see list of users who joined campaign
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should not see "1 user have joined"

  Scenario: User is able to see list of users who joined campaign
    Given I am logged in as "rodowi"
    When I go to campaign "Experience Virgin America"
    Then I should see "1 user have joined"
    And I should not see button "Unsubscribe"

