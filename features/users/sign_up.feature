Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

  Background:
    Given I am not logged in

  Scenario: User signs up with valid data
    When I sign up with valid user data
    Then I should see "A message with a confirmation link has been sent to your email address."

  Scenario: User signs up with invalid email
    When I sign up with an invalid email
    Then I should see "Emailis invalid"

  Scenario: User signs up without password
    When I sign up without a password
    Then I should see "Passwordcan't be blank"

  Scenario: User signs up without password confirmation
    When I sign up without a password confirmation
    Then I should see "Passworddoesn't match confirmation"

  Scenario: User signs up with mismatched password and confirmation
    When I sign up with a mismatched password confirmation
    Then I should see "Passworddoesn't match confirmation"
