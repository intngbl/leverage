Feature: Manage a list of users who joined a campaign
  In order manage my campaigns
  As an agency
  I want to be able to see a list of users who have joined

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist
    And User "rodowi" is enrolled in campaign "Experience Virgin America"

  Scenario: Guest can't see list of joined users per campaign
    Given I am not logged in
    When I go to campaign "Experience Virgin America"
    Then I should not see "1 user have joined"

  Scenario: User can see list of joined users per campaign
    Given I am logged in as "SEMANA"
    When I go to campaign "Experience Virgin America"
    And I follow "1 user have joined"
    Then I should see "rodowi"
    And I should see button "Accept"
    And I should see button "Decline"

  Scenario: Agency can decline user request to join campaign
    Given I am logged in as "SEMANA"
    And I go to campaign "Experience Virgin America"
    And I follow "1 user have joined"
    When I click "Decline"
    Then "Experience Virgin America" should have 0 users

  Scenario: Agency can accept user request to join campaign
    Given I am logged in as "SEMANA"
    And I go to campaign "Experience Virgin America"
    And I follow "1 user have joined"
    When I click "Accept"
    Then I should see button "Unsubscribe"

