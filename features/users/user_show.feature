Feature: Show Users
  As admin
  I want to see registered users listed on the homepage
  so I can know if the site has users

  Scenario: Viewing users
    Given I am logged in as admin
    When I look at the list of users
    Then I should see my name
