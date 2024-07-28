Feature: Filtering notes
  As a program director
  I want to filter notes by different attributes
  So that I can find specific notes

  Background:
    Given I am logged in with Google as Program Manager
    And the following students exist for filtering tests:
      | name                | uin        |
      | Dominique O'Connell | 765656210  |
      | Felipe Spencer      | 940297835  |
    And the following notes exist for filtering tests:
      | student_name        | note              | note_created_date | followup_date  | followup_action | action_completed |
      | Dominique O'Connell | Follow up note 1  | 2023-01-01        | 2023-01-02     | Action 1        | true             |
      | Dominique O'Connell | Follow up note 2  | 2023-02-01        | 2023-02-02     | Action 2        | false            |
      | Felipe Spencer      | Follow up note 3  | 2023-03-01        | 2023-03-02     | Action 3        | true             |
      | Felipe Spencer      | Follow up note 4  | 2023-04-01        | 2023-04-02     | Action 4        | false            |
    Given I am on the notes page for "Dominique O'Connell"

  Scenario: Filter by note content
    When I filter notes by inputting "Note" with "Follow up note 1"
    And I filter notes by pressing "Filter"
    Then I should see the note with content "Follow up note 1"
    And I should not see the note with content "Follow up note 2"
    And I should not see the note with content "Follow up note 3"
    And I should not see the note with content "Follow up note 4"

  Scenario: Filter by action completed
    When I filter notes by selecting "Yes" from "Done?"
    And I filter notes by pressing "Filter"
    Then I should see the note with content "Follow up note 1"
    And I should not see the note with content "Follow up note 2"
    And I should not see the note with content "Follow up note 3"
    And I should not see the note with content "Follow up note 4"
