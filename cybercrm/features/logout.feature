Feature: User Logout

  Scenario: User logs out
    Given I am logged in with Google
    When I visit the home page
    And I click the sign out button
    Then I should be redirected to the root page
    And I should see a sign-out notice
    And I should not be logged in
