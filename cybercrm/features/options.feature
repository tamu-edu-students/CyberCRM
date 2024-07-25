Feature: Options Management
  As an admin
  I want to manage options
  So that I can ensure correct data is available for students

  Background:
    Given I am logged in with Google as Program Manager

  @javascript
  Scenario: Viewing options
    When I visit the options page
    Then I should see a list of options

  @javascript
  Scenario: Creating a new option
    When I visit the new option page
    And I select "Gender" from "Field"
    And I select "dropdown" from "Display type"
    And I wait for the options input to be visible
    And I fill in "Options (comma-separated)" with "Non-binary"
    And I press "Create Option"
    Then I should see "Non-binary" in the options list
