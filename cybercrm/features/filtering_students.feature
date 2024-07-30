Feature: Filtering students
  As a program director
  I want to filter students by different attributes
  So that I can find specific groups of students

  Background:
    Given I am logged in with Google as Program Manager
    And the following students exist for filtering tests:
      | name                | uin        | grade_ryg | gender | ethnicity       | nationality | expected_graduation | university_classification | status   | sexual_orientation | date_of_birth | email               |
      | Dominique O'Connell | 765656210  | G         | Male   | Black           | Canadian    | 2027-09-01          | Graduate                  | Active   | Heterosexual       | 1997-05-23    | do'connell@tamu.edu |
      | Felipe Spencer      | 940297835  | G         | Male   | Asian           | Australian  | 2028-01-11          | Senior                    | Active   | Homosexual         | 1995-05-29    | fspencer@tamu.edu   |
      | Rogelio Ortiz       | 189259688  | R         | Male   | Hispanic/Latino | Other       | 2026-10-10          | Junior                    | Active   | Heterosexual       | 1999-05-14    | rortiz@tamu.edu     |
      | Elwood King         | 536964095  | G         | Male   | Native American | Japanese    | 2026-09-12          | Sophomore                 | Active   | Heterosexual       | 1997-12-22    | eking@tamu.edu      |
      | Diego Emmerich      | 640147240  | R         | Male   | Native American | British     | 2026-10-23          | Graduate                  | Active   | Heterosexual       | 2002-11-22    | demmerich@tamu.edu  |
    Given I am on the students page

  Scenario: Filter by nationality
    When I select "Canadian" from "Nationality" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should not see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by university classification
    When I select "Graduate" from "University Classification" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should see "Diego Emmerich" in the students table
    And I should not see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table

  Scenario: Filter by sexual orientation
    When I select "Homosexual" from "Sexual Orientation" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Felipe Spencer" in the students table
    And I should not see "Dominique O'Connell" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by email
    When I input "Email" with "fspencer@tamu.edu" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Felipe Spencer" in the students table
    And I should not see "Dominique O'Connell" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by name
    When I input "Name" with "Dominique O'Connell" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should not see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by UIN
    When I input "UIN" with "765656210" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should not see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by grade
    When I select "G" from "grade_ryg" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table

  Scenario: Filter by gender
    When I select "Male" from "Gender" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should see "Felipe Spencer" in the students table
    And I should see "Rogelio Ortiz" in the students table
    And I should see "Elwood King" in the students table
    And I should see "Diego Emmerich" in the students table

  Scenario: Filter by ethnicity
    When I select "Black" from "Ethnicity" in the students filter
    And I press "Apply Filters" in the students filter
    Then I should see "Dominique O'Connell" in the students table
    And I should not see "Felipe Spencer" in the students table
    And I should not see "Rogelio Ortiz" in the students table
    And I should not see "Elwood King" in the students table
    And I should not see "Diego Emmerich" in the students table
