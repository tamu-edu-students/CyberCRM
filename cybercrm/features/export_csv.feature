Feature: Download CSV of students
  As an admin
  I want to download a CSV file of students
  So that I can analyze student data offline

  Scenario: Admin downloads CSV file
    Given I am logged in with Google
    Given I am on the students page
    When I click the "Export CSV" link
    Then I should receive a file ending in .csv

  Scenario: Successfully export students to a CSV file
    Given I am logged in with Google
    Given I am on the students page
    Given the following students exist:
      | name | uin        | grade_ryg | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
      | John | 123456789  | G         | Male   | White     | American    | 2025-05-10          | Senior                    | Active | Homosexual         | 2003-03-03    | john@example.com     |
    When I click the "Export CSV" button
    Then I should receive a CSV file with the following content:
      | name | uin        | grade_ryg | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
      | John | 123456789  | G         | Male   | White     | American    | 2025-05-10          | Senior                    | Active | Homosexual         | 2003-03-03    | john@example.com     |