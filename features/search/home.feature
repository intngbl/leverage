Feature: As user I should be able to search for campaigns at the home page
  In order to find campaigns
  As user
  I want to be able to search

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist
    And I am logged in as "rodowi"
    And I visit "/"

  Scenario: User searches agency
    When I fill in "q_title_cont" with "SEMANA"
    And I click "Search"
    Then I should not see "SEMANA"

  Scenario: User searches campaigns
    When I fill in "q_title_cont" with "Virgin America"
    And I click "Search"
    Then I should see "Campaigns"
    And I should see "Virgin America"
    And I should see "9.99"

