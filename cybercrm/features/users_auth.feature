Feature: User Authorization

  Scenario: Super user updates a user
    Given I am logged in as a super user
    And a user exists
    When I visit the edit user page
    And I update the user form with valid data
    And I submit the user edit form
    Then I should see the user has been updated

  Scenario: Non-super user tries to update a user
    Given I am logged in as a non-super user
    And a user exists
    When I visit the edit user page
    Then I should see an unauthorized alert
