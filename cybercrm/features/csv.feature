Feature: Download CSV of students
  As an admin
  I want to download a CSV file of students
  So that I can analyze student data offline

  Scenario: Admin downloads CSV file
    Given I am logged in with Google
    Given I am on the students page
    When I click the "Export CSV" link
    Then I should receive a file ending in .csv