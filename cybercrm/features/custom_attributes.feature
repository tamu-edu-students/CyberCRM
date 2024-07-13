Feature: Manage Custom Attributes

  Scenario: User creates a new custom attribute
    Given I am on the new custom attribute page
    When I fill in the custom attribute form with valid data
    And I submit the custom attribute create form
    Then I should see the custom attribute has been created

  Scenario: User updates a custom attribute
    Given a custom attribute exists
    And I am on the edit custom attribute page for the existing custom attribute
    When I update the custom attribute form with valid data
    And I submit the custom attribute edit form
    Then I should see the custom attribute has been updated

  Scenario: User toggles the active status of a custom attribute
    Given a custom attribute exists
    And I am on the custom attributes list page
    When I click the toggle status button for the custom attribute
    Then I should see the custom attribute status has been toggled

  Scenario: Retrieve custom attribute value for a student
    Given a student with a custom attribute exists
    When I retrieve the custom attribute value
    Then I should see the custom attribute value
