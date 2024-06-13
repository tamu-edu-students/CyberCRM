Feature: User Authentication

  Scenario: User signs in with Google
    Given I am on the homepage
    When I click "Sign in with Google"
    And I authenticate successfully with Google
    Then I should see "Welcome, John Doe"
    And a user record should exist with email "john.doe@tamu.edu"

  Scenario: User signs in with an existing Google account
    Given a user with email "existing@tamu.edu" and provider "google_oauth2" exists
    And I am on the homepage
    When I click "Sign in with Google"
    And I authenticate successfully with Google as "existing@tamu.edu"
    Then I should see "Welcome back, Existing User"
    And there should still be only one user record with email "existing@tamu.edu"
