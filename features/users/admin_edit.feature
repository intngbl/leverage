Feature: Edit other users roles
  As admin of the website
  I am able to edit other users roles

  Background:
    Given Roles are defined

  @javascript
  Scenario: I sign in as admin and edit a user's role
    Given I am logged in as admin
    And Another random user exist
    When I edit that user's role
    Then I should see an user updated message

