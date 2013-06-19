Feature: Watch a list of campaigns published by agency
  In order to see what campaigns are published
  As a regular user or guest
  I want to be able to see a list campaigns per agency or per user

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist
    And User "rodowi" is enrolled in campaign "Experience Virgin America"

  Scenario: Anyone can see the list of campaigns per agency
    Given I am not logged in
    When I go to the list of SEMANA campaigns
    Then I should see 2 campaigns

  Scenario: Trying to get the list of campaigns created by a tweeter should redirect to user page
    Given I am logged in as "rodowi"
    When I go to the list of rodowi campaigns
    Then I should see "rodowi"

