Feature: Student management
  As an admin
  I want to manage students
  So that I can keep the student records up-to-date

Scenario: Creating a student
    Given I am on the new student page
    When I fill in the student form with valid data
    And I submit the create form
    Then I should see the student has been created

Scenario: Viewing a student
    Given a student exists
    When I visit the student's page
    Then I should see the student's details

Scenario: Editing a student
    Given a student exists
    When I visit the edit student page
    And I update the student form with valid data
    And I submit the edit form
    Then I should see the student has been updated

Scenario: Deleting a student
    Given a student exists
    When I visit the student's page
    And I click the delete button
    Then I should see the student has been deleted