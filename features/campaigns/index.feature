Feature: Watch a list of campaigns published by agency
  In order to see what campaigns are published
  As a regular user or guest
  I want to be able to see a list campaigns per agency

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns

  Scenario: Anyone can see the list of campaigns per agency
    Given I am not logged in
    When I go to the list of SEMANA campaigns
    Then I should see 2 campaigns

