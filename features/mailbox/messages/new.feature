Feature: Send a message to a user
  In order to start a conversation with another user
  As a regular user
  I want to be able to send a message

  Background:
    Given Agency SEMANA exist
    And Tweeter rodowi exist
    And I visit "/"

  Scenario: Guests can't create messages
    Given I am not logged in
    When I visit "/messages/new"
    Then I should see t("devise.failure.unauthenticated")

  Scenario: User fails to send a message
    Given I am logged in as "rodowi"
    And I visit "/messages/new"
    When I fill in "message_body" with "This shall failed"
    And I press "Send"
    Then I should see t("messages.create.failure")

  Scenario: User send a message
    Given I am logged in as "rodowi"
    And I follow "Mailbox"
    And I follow "New message"
    When I fill in "_recipients" with "SEMANA"
    When I fill in "message_subject" with "Howdy!"
    When I fill in "message_body" with "Looking for a twitter rockstar?"
    And I press "Send"
    Then I should see t("messages.create.success")

