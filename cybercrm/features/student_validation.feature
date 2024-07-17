Feature: Student validation
  As a user
  I want to ensure the student attributes are correctly validated
  So that only valid students can be created

  Scenario: Expected graduation date in the past
    Given I am logged in with Google as Program Manager
    Given I am on the new student page
    When I fill in "Expected graduation" with "2020-01-01"
    And I fill in "Date of birth" with "2000-01-01"
    And I submit the form
    Then I should see "Expected graduation must be in the future"

  Scenario: Date of birth less than 10 years ago
    Given I am logged in with Google as Program Manager
    Given I am on the new student page
    When I fill in "Expected graduation" with "2025-12-31"
    And I fill in "Date of birth" with "2015-01-01"
    And I submit the form
    Then I should see "Date of birth must be at least 10 years ago"
