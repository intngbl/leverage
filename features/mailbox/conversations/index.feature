Feature: Check a list of conversations with other users
  In order to keep a conversation with other user
  As a regular user
  I want to be able to see a list of my conversations

  Background:
    Given Agency SEMANA exist
    And Agency MATRIX exist
    And Tweeter rodowi exist
    And "SEMANA" "sent" a message to "rodowi"

  Scenario: Guests can't see conversations
    Given I am not logged in
    When I go to my conversations
    Then I should see t("devise.failure.unauthenticated")

  Scenario: Users can check their conversations
    Given I am logged in as "rodowi"
    And I visit "/"
    When I follow "Mailbox"
    Then I should see "SEMANA"

