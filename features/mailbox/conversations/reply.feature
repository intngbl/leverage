Feature: Reply in a conversation
  In order to keep a conversation with other user
  As a regular user
  I want to be able to send a message in reply

  Background:
    Given Agency SEMANA exist
    And Tweeter rodowi exist
    And "SEMANA" "sent" a message to "rodowi"
    And I visit "/"
    And I am logged in as "rodowi"

  Scenario: User replies to a conversation
    Given I follow "Mailbox"
    And I follow conversation 1
    And I fill in "message_body" with "watcha' talkin' 'bout willis?"
    When I press "Send"
    Then I should see t("messages.create.success")
    And I should see "Lorem"
    And I should see "watcha"

