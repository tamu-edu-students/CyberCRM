Feature: Search and filter students
  As a user
  I want to search for a student named "test" and filter students with certifications greater than 3
  So that I can find the relevant students easily

  Background:
    Given the following students exist:
      | name | age | grade_ryg | uin | gpa | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                | certifications |
      | test | 20  | Green     | 1   | 3.5 | male   | Asian     | USA         | 2024-05-10          | junior                    | active | heterosexual       | 2004-04-04    | test1@example.com    | 4              |
      | test | 22  | Yellow    | 2   | 3.2 | male   | Asian     | USA         | 2024-05-10          | senior                    | active | heterosexual       | 2002-02-02    | test2@example.com    | 2              |
      | John | 21  | Red       | 3   | 3.8 | male   | Caucasian | USA         | 2024-05-10          | senior                    | active | homosexual         | 2003-03-03    | john@example.com     | 5              |

  Scenario: Search for student named "test" and filter certifications > 3
    When I go to the students page
    And I fill in "search_name" with "test"
    And I fill in "certifications_greater_than" with "3"
    And I press "Search"
    Then I should see "test"
    And I should not see "John"
    And I should not see "test" with "certifications" less than or equal to 3
