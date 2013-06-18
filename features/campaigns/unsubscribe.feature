Feature: Campaign owners should be able to unsubscribe users
  In order to manage who have access to the campaign
  As an agency
  I want to be able to unsubscribe users

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Agency can unsubscribe users from a campaign
    Given I am logged in as "SEMANA"
    And User "rodowi" is enrolled in campaign "Experience Virgin America"
    When I go to campaign "Experience Virgin America"
    And I follow "1 user have joined"
    And I press "Unsubscribe"
    Then I should see "Unsubscribed successfully."
    And "Experience Virgin America" should have 0 users

