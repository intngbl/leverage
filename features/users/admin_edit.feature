Feature: Edit Other Users Roles
  As admin of the website
  I am able to edit other users roles

    Scenario: I sign in as admin and edit a user's role
      Given I am logged in as admin
      And Another user exist
      When I edit that user's role
      Then I should see an user updated message

