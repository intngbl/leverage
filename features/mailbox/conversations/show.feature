Feature: Follow up a conversation
  In order to keep a conversation with other user
  As a regular user
  I want to be able to see the messages in the conversations and reply

  Background:
    Given Agency SEMANA exist
    And Agency MATRIX exist
    And Tweeter rodowi exist
    And "SEMANA" "sent" a message to "rodowi"

  Scenario: Users can check a conversation
    Given I am logged in as "rodowi"
    And I visit "/"
    When I follow "Mailbox"
    And I follow conversation 1
    Then I should see "Hey!"
    And I should see "Lorem ipsum"

  Scenario: Reply-to field should include original sender
    Given I am logged in as "rodowi"
    And I follow "Mailbox"
    When I follow conversation 1
    Then I should see "Reply to"
    And I should see disabled field "_recipients" with "SEMANA"'s email

