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
    When I input "note" with "Follow up note 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by action completed
    When I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by Date Entered
    When I input "Date Entered" with "2023-01-01" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by Follow Up Date
    When I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by Follow Up Action
    When I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by multiple attributes
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by Date Entered and Follow Up Date
    When I input "Date Entered" with "2023-01-01" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name and note
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name and note created date
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Date Entered" with "2023-01-01" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note and follow up date
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by three attributes: student name, note, and note created date
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Date Entered" with "2023-01-01" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by three attributes: student name, note, and follow up date
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by three attributes: note, note created date, and follow up date
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Date Entered" with "2023-01-01" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note created date and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Date Entered" with "2023-01-01" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by follow up action and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Action" with "Action 1" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by follow up date and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name, follow up date, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note, follow up date, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name, note, and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name, note created date, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Date Entered" with "2023-01-01" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name, follow up date, and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note, note created date, and follow up action
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Date Entered" with "2023-01-01" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by follow up date, follow up action, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Date" with "2023-01-02" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by student name, follow up action, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "Follow Up Action" with "Action 1" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table

  Scenario: Filter by note, follow up action, and action completed
    Given I am on the notes page for "Dominique O'Connell"
    When I input "note" with "Follow up note 1" in the notes filter
    And I input "Follow Up Action" with "Action 1" in the notes filter
    And I select "Yes" from "action_completed" in the notes filter
    And I press "Filter" in the notes filter
    Then I should see "Follow up note 1" in the notes table
    And I should not see "Follow up note 2" in the notes table
    And I should not see "Follow up note 3" in the notes table
    And I should not see "Follow up note 4" in the notes table
