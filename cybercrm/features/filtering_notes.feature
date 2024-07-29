Feature: Filtering notes
  As a program director
  I want to filter notes by different attributes
  So that I can find specific notes

  Background:
    Given I am logged in with Google as Program Manager
    And the following students exist for filtering tests:
      | name                | uin        | grade_ryg | gender | ethnicity       | nationality | expected_graduation | university_classification | status   | sexual_orientation | date_of_birth | email               |
      | Dominique O'Connell | 765656210  | G         | Male   | Black           | Canadian    | 2027-09-01          | Graduate                  | Active   | Heterosexual       | 1997-05-23    | do'connell@tamu.edu |
      | Felipe Spencer      | 940297835  | G         | Male   | Asian           | Australian  | 2028-01-11          | Senior                    | Active   | Homosexual         | 1995-05-29    | fspencer@tamu.edu   |
    And the following notes exist for filtering tests:
      | student_name        | note              | note_created_date | followup_date  | followup_action | action_completed | status |
      | Dominique O'Connell | Follow up note 1  | 2023-01-01        | 2023-01-02     | Action 1        | true             | Active |
      | Dominique O'Connell | Follow up note 2  | 2023-02-01        | 2023-02-02     | Action 2        | false            | Active |
      | Felipe Spencer      | Follow up note 3  | 2023-03-01        | 2023-03-02     | Action 3        | true             | Active |
      | Felipe Spencer      | Follow up note 4  | 2023-04-01        | 2023-04-02     | Action 4        | false            | Active |
    Given I am on the notes page for "Dominique O'Connell"

  Scenario: Filter by note content
    When I input "Note" with "Follow up note 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by action completed
    When I select "Yes" from "Done?" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table
