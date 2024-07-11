Feature: User Authentication

  Scenario: User signs in with Google
    Given I am on the login page
    Then On the login page, I should see "LOGIN"
    Given I am logged in with Google
    Then I should see "Signed in!"

  Scenario: Super user signs in and out
    Given I am logged in with Google
    Then I should see "Signed in!"
    When I log out
    Then I should see that I have been logged out

  Scenario: Program director signs in and out
    Given I am logged in as a program director
    Then I should see "Signed in!"
    When I log out
    Then I should see that I have been logged out

  Scenario: Student worker signs in and out
    Given I am logged in as a student worker
    Then I should see "Signed in!"
    When I log out
    Then I should see that I have been logged out
