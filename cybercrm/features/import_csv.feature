Feature: Import students from CSV
  As an admin
  I want to import students from a CSV file
  So that I can quickly add multiple students

  Scenario: Successfully import students from a CSV file
    Given I am logged in with Google
    Given I am on the students page
    Given the following students exist:
      | name | uin        | grade_ryg | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
      | John | 123456789  | G         | Male   | White     | American    | 2025-05-10          | Senior                    | Active | Homosexual         | 2003-03-03    | john@example.com     |
    When I upload a valid CSV file
    Then I should see "Students imported successfully"
    And I should see the following students:
      | name | uin        | grade_ryg | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
      | John | 123456789  | G         | Male   | White     | American    | 2025-05-10          | Senior                    | Active | Homosexual         | 2003-03-03    | john@example.com     |
