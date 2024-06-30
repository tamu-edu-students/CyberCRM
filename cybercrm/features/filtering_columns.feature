Feature: Column sorting
  As a user
  I want to sort columns in the students table
  So that I can view the data in the desired order

  Scenario: Sorting by name
    Given I am on the students index page
    When I click the "Name" column header
    Then I should see students sorted by "Name" in ascending order

    When I click the "Name" column header
    Then I should see students sorted by "Name" in descending order

    When I click the "Name" column header
    Then I should see students sorted by "Name" in the default order

  Scenario: Sorting by UIN
    Given I am on the students index page
    When I click the "UIN" column header
    Then I should see students sorted by "UIN" in ascending order

    When I click the "UIN" column header
    Then I should see students sorted by "UIN" in descending order

    When I click the "UIN" column header
    Then I should see students sorted by "UIN" in the default order

  Scenario: Sorting by Grade_ryg
    Given I am on the students index page
    When I click the "Grade_RYG" column header
    Then I should see students sorted by "Grade_RYG" in ascending order

    When I click the "Grade_RYG" column header
    Then I should see students sorted by "Grade_RYG" in descending order

    When I click the "Grade_RYG" column header
    Then I should see students sorted by "Grade_RYG" in the default order

  Scenario: Sorting by Gender
    Given I am on the students index page
    When I click the "Gender" column header
    Then I should see students sorted by "Gender" in ascending order

    When I click the "Gender" column header
    Then I should see students sorted by "Gender" in descending order

    When I click the "Gender" column header
    Then I should see students sorted by "Gender" in the default order

  Scenario: Sorting by Ethnicity
    Given I am on the students index page
    When I click the "Ethnicity" column header
    Then I should see students sorted by "Ethnicity" in ascending order

    When I click the "Ethnicity" column header
    Then I should see students sorted by "Ethnicity" in descending order

    When I click the "Ethnicity" column header
    Then I should see students sorted by "Ethnicity" in the default order

  Scenario: Sorting by Nationality
    Given I am on the students index page
    When I click the "Nationality" column header
    Then I should see students sorted by "Nationality" in ascending order

    When I click the "Nationality" column header
    Then I should see students sorted by "Nationality" in descending order

    When I click the "Nationality" column header
    Then I should see students sorted by "Nationality" in the default order

  Scenario: Sorting by Expected Graduation
    Given I am on the students index page
    When I click the "Expected Graduation" column header
    Then I should see students sorted by "Expected Graduation" in ascending order

    When I click the "Expected Graduation" column header
    Then I should see students sorted by "Expected Graduation" in descending order

    When I click the "Expected Graduation" column header
    Then I should see students sorted by "Expected Graduation" in the default order

  Scenario: Sorting by University Classification
    Given I am on the students index page
    When I click the "University Classification" column header
    Then I should see students sorted by "University Classification" in ascending order

    When I click the "University Classification" column header
    Then I should see students sorted by "University Classification" in descending order

    When I click the "University Classification" column header
    Then I should see students sorted by "University Classification" in the default order

  Scenario: Sorting by Status
    Given I am on the students index page
    When I click the "Status" column header
    Then I should see students sorted by "Status" in ascending order

    When I click the "Status" column header
    Then I should see students sorted by "Status" in descending order

    When I click the "Status" column header
    Then I should see students sorted by "Status" in the default order

  Scenario: Sorting by Sexual Orientation
    Given I am on the students index page
    When I click the "Sexual Orientation" column header
    Then I should see students sorted by "Sexual Orientation" in ascending order

    When I click the "Sexual Orientation" column header
    Then I should see students sorted by "Sexual Orientation" in descending order

    When I click the "Sexual Orientation" column header
    Then I should see students sorted by "Sexual Orientation" in the default order

  Scenario: Sorting by Date of Birth
    Given I am on the students index page
    When I click the "Date of Birth" column header
    Then I should see students sorted by "Date of Birth" in ascending order

    When I click the "Date of Birth" column header
    Then I should see students sorted by "Date of Birth" in descending order

    When I click the "Date of Birth" column header
    Then I should see students sorted by "Date of Birth" in the default order
