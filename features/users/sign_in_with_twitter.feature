Feature: Sign in with Twitter
  In order to get access to protected sections of the site
  A user
  Should be able to sign in using Twitter

  @omniauth_test
  Scenario: Only email is needed to complete registration
    Given I do not exist as a user
    And I return to the site
    When I follow "Sign in with Twitter"
    Then I should see "Emailcan't be blank"
    And I should not see "Password"

  @omniauth_test
  Scenario: User signs up successfully
    Given I do not exist as a user
    And I return to the site
    And I sign in with Twitter
    And I fill in "user_email" with "rod@wilhel.me"
    When I click "Sign up"
    Then I should not see "A message with confirmation link"
    And I should see "signed up successfully"
    And I should be signed in
    And My role should be tweeter

  @omniauth_test
  Scenario: User signs in successfully
    Given I exist as a twitter user
    And I sign in with Twitter
    When I should see "Signed in successfully."
    Then I should be signed in

  @omniauth_test
  Scenario: Signed in user updates profile
    Given I exist as a twitter user
    And I sign in with Twitter
    When I update my "user_name" to "Randalf"
    Then I should see "You updated your account successfully."
    And I visit "Randalf" profile
    And I should see "Randalf"

