Feature: List tweets from a campaign
  In order to manage what tweets are to be published
  As an agency
  I want to be able to see a list of tweets per campaign

  Background:
    Given Roles are defined
    And Agency SEMANA exist
    And Agency SEMANA has 2 campaigns
    And Tweeter rodowi exist

  Scenario: Anonymous users should not be able to see list of tweets
    Given I am not logged in
    When I go to the list of "Experience Virgin America" tweets
    Then I should see "You need to sign in or sign up before continuing."

  Scenario: Not everyone can see the list of tweets per campaign
    Given I am logged in as "rodowi"
    When I go to the list of "Experience Virgin America" tweets
    Then I should see "You are not authorized"

  Scenario: As agency I can see the list of tweets of a campaign
    Given I am logged in as "SEMANA"
    When I go to the list of "Experience Virgin America" tweets
    Then I should see "Tweets for"

