@search_student
Feature: Search for students
  As a user
  I want to search for a student named "test"
  So that I can find the relevant students easily

  Background:
  Given the following students exist:
    | name | uin        | grade_ryg | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
    | test | 123456789  | G         | Male   | Asian     | American    | 2025-05-10          | Junior                    | Active | Heterosexual       | 2004-04-04    | test1@example.com    |
    | test | 123456787  | G         | Male   | Asian     | American    | 2025-05-10          | Senior                    | Active | Heterosexual       | 2002-02-02    | test2@example.com    |
    | John | 123456786  | G         | Male   | White     | American    | 2025-05-10          | Senior                    | Active | Homosexual         | 2003-03-03    | john@example.com     |

  Scenario: Search for student named "test"
    Given I am logged in with Google
    When I go to the students page
    And I click on the search icon
    And I fill in the search field with "te"
    Then I should see "test" in the search results
    And I should not see "John" in the search results
