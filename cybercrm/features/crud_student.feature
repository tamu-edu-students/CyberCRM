Feature: Manage students

  Scenario: User creates a new student
    Given I am logged in with Google as Program Manager
    And I am on the new student page
    When I fill in the student form with valid data
    And I submit the create form
    Then I should see the student has been created

  Scenario: User updates a student
    Given I am logged in with Google as Program Manager
    And a student exists
    When I visit the edit student page
    And I update the student form with valid data
    And I submit the edit form
    Then I should see the student has been updated

  Scenario: User deletes a student
    Given I am logged in with Google as Program Manager
    And a student exists
    When I click the delete button
    Then I should see the student has been deleted
