Feature: Sorting notes
  As a user
  I want to sort columns in the notes table
  So that I can view the data in the desired order

  Background:
    Given I am logged in with Google as Program Manager
    And the following students exist for sorting tests:
      | name                | uin        | grade_ryg | gender | ethnicity       | nationality | expected_graduation | university_classification | status   | sexual_orientation | date_of_birth | email               |
      | Dominique O'Connell | 765656210  | G         | Male   | Black           | Canadian    | 2027-09-01          | Graduate                  | Active   | Heterosexual       | 1997-05-23    | do'connell@tamu.edu |
      | Felipe Spencer      | 940297835  | G         | Male   | Asian           | Australian  | 2028-01-11          | Senior                    | Active   | Homosexual         | 1995-05-29    | fspencer@tamu.edu   |
    And the following notes exist for sorting tests:
      | student_name        | note              | note_created_date | followup_date  | followup_action | action_completed |
      | Dominique O'Connell | Follow up note 1  | 2023-01-01        | 2023-01-02     | Action 1        | true             |
      | Dominique O'Connell | Follow up note 2  | 2023-02-01        | 2023-02-02     | Action 2        | false            |
      | Felipe Spencer      | Follow up note 3  | 2023-03-01        | 2023-03-02     | Action 3        | true             |
      | Felipe Spencer      | Follow up note 4  | 2023-04-01        | 2023-04-02     | Action 4        | false            |
    Given I am on the notes page for "Dominique O'Connell"

  Scenario: Sorting by note_created_date
    When I click the "Date Entered" column header in notes table
    Then I should see notes sorted by "Date Entered" in ascending order in notes table

    When I click the "Date Entered" column header in notes table
    Then I should see notes sorted by "Date Entered" in descending order in notes table

    When I click the "Date Entered" column header in notes table
    Then I should see notes sorted by "Date Entered" in the default order in notes table

  Scenario: Sorting by note content
    When I click the "Note" column header in notes table
    Then I should see notes sorted by "Note" in ascending order in notes table

    When I click the "Note" column header in notes table
    Then I should see notes sorted by "Note" in descending order in notes table

    When I click the "Note" column header in notes table
    Then I should see notes sorted by "Note" in the default order in notes table

  Scenario: Sorting by followup_date
    When I click the "Follow Up Date" column header in notes table
    Then I should see notes sorted by "Follow Up Date" in ascending order in notes table

    When I click the "Follow Up Date" column header in notes table
    Then I should see notes sorted by "Follow Up Date" in descending order in notes table

    When I click the "Follow Up Date" column header in notes table
    Then I should see notes sorted by "Follow Up Date" in the default order in notes table

  Scenario: Sorting by followup_action
    When I click the "Follow Up Action" column header in notes table
    Then I should see notes sorted by "Follow Up Action" in ascending order in notes table

    When I click the "Follow Up Action" column header in notes table
    Then I should see notes sorted by "Follow Up Action" in descending order in notes table

    When I click the "Follow Up Action" column header in notes table
    Then I should see notes sorted by "Follow Up Action" in the default order in notes table

  Scenario: Sorting by action_completed
    When I click the "Done?" column header in notes table
    Then I should see notes sorted by "Done?" in ascending order in notes table

    When I click the "Done?" column header in notes table
    Then I should see notes sorted by "Done?" in descending order in notes table

    When I click the "Done?" column header in notes table
    Then I should see notes sorted by "Done?" in the default order in notes table
