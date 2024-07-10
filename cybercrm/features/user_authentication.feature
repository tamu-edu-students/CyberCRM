Feature: User Authentication

  Scenario: User signs in with Google
    Given I am logged in with Google
    Given I am on the login page
    Then On the login page, I should see "LOGIN"
