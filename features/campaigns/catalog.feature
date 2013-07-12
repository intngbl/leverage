Feature: Watch a list of all campaigns in the platform
  In order to see what campaigns are published
  As a regular user or guest
  I want to be able to see a list of all campaigns

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Guests can't see the list of campaigns
    Given I am not logged in
    When I visit "/campaigns"
    Then I should see "You need to sign in"

  @allow-rescue
  Scenario: Logged user can see the list of all campaigns
    Given I am logged in as "rodowi"
    And Thus able to catalog a campaign
    When I visit "/campaigns"
    Then I should not see "You are not authorized"
    And I should see "Campaigns"

