Feature: Manage users

  Scenario: User creates a new user
    Given I am logged in with Google
    And I am on the new user page
    When I fill in the user form with valid data
    And I submit the user create form
    Then I should see the user has been created

  Scenario: User updates a user
    Given I am logged in with Google
    And a user exists
    When I visit the users list page
    And I click the user row
    And I click the edit button
    And I update the user form with valid data
    And I submit the user edit form
    Then I should see the user has been updated

  Scenario: User deletes a user
    Given I am logged in with Google
    And a user exists
    When I visit the users list page
    And I click the user row
    And I click the user delete button
    Then I should see the user has been deleted
