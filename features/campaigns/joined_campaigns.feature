Feature: Watch a list of campaigns joined by user
  In order to see what campaigns have a user joined
  As a regular user or guest
  I want to be able to see a list campaigns joined per user

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist
    And User "rodowi" is enrolled in campaign "Experience Virgin America"

  Scenario: Guest can't see list of joined campaigns for a user
    Given I am not logged in
    When I go to the list of rodowi joined campaigns
    Then I should see "You need to sign in"

  Scenario: Users can see the list of joined campaigns per user
    Given I am logged in as "rodowi"
    When I go to the list of rodowi joined campaigns
    Then I should see 1 campaigns

  Scenario: I can access joined campaigns by following link on user's profile
    Given I am logged in as "SEMANA"
    When I visit "rodowi" profile
    And I follow "Joined campaigns"
    Then I should see 1 campaigns

  Scenario: A profile for an agency should not display a joined campaigns link
    Given I am logged in as "rodowi"
    When I visit "SEMANA" profile
    Then I should see "Campaigns"

  Scenario: User can access list of joined campaigns
    Given I am logged in as "rodowi"
    And I should see "Joined campaigns"
    When I follow "Joined campaigns"
    Then I should see 1 campaigns

  Scenario: User tries to see list of joined campaigns for an agency
    Given I am logged in as "rodowi"
    When I go to the list of SEMANA joined campaigns
    Then I should see "SEMANA"

  Scenario: List of joined campaigns is updated when user leaves campaign
    Given I am logged in as "rodowi"
    When I go to campaign "Experience Virgin America"
    And I press "Leave"
    And I go to the list of rodowi joined campaigns
    Then I should see 0 campaigns

  Scenario: User access list of joined campaigns
    Given I am logged in as "rodowi"
    And User "rodowi" is authorized in campaign "Experience Virgin America"
    When I go to the list of rodowi joined campaigns
    Then I should see "approved"

