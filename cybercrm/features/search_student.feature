@search_student
Feature: Search for students
  As a user
  I want to search for a student named "test"
  So that I can find the relevant students easily

  Background:
    Given the following students exist:
      | name | uin | gpa   | gender | ethnicity | nationality | expected_graduation | university_classification | status | sexual_orientation | date_of_birth | email                |
      | test | 1   | 3.5   | male   | Asian     | USA         | 2024-05-10          | junior                    | active | heterosexual       | 2004-04-04    | test1@example.com    |
      | test | 2   | 3.2   | male   | Asian     | USA         | 2024-05-10          | senior                    | active | heterosexual       | 2002-02-02    | test2@example.com    |
      | John | 3   | 3.8   | male   | Caucasian | USA         | 2024-05-10          | senior                    | active | homosexual         | 2003-03-03    | john@example.com     |

  Scenario: Search for student named "test"
    When I go to the students page
    And I click on the search icon
    And I fill in the search field with "te"
    Then I should see "test" in the search results
    And I should not see "John" in the search results
