Feature: Account confirmation
  When user signs up,
  a confirmation process should be completed
  to use the account

    Background:
      Given I exist as an unconfirmed user
      And Roles are defined

    Scenario: User confirms account without changing any value
      When I follow the confirmation link
      And Confirm my account
      Then Î should see a successful account confirmation message

    Scenario: User confirms account and chooses a role
      When I follow the confirmation link
      And Select my role as agency
      And Confirm my account
      Then Î should see a successful account confirmation message
      And My role should be agency

