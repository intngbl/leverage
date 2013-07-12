Feature: As user I should be able to search for campaigns of a specific user
  In order to find campaigns of an agency
  As user
  I want to be able to search for campaigns of a user

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Agency MATRIX exist
    And Agency MATRIX has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Guest searches agency's campaigns
    Given I visit "SEMANA" profile
    Then I should see "You need to sign in or sign up before continuing."

  Scenario: User searches agency's campaigns
    Given I am logged in as "rodowi"
    And I visit "SEMANA" campaigns
    Then I should see 2 campaigns

