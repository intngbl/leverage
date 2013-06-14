Feature: Show Users
  As admin
  I want to see registered users listed on the homepage
  so I can know if the site has users

  Scenario: Viewing list of users as admin
    Given I am logged in as admin
    When I look at the list of users
    Then I should see my name

  Scenario: Trying to view list of users as guest
    Given I am not logged in
    When I look at the list of users
    Then I should see "You need to sign in or sign up before continuing."
