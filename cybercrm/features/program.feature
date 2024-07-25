Feature: Manage Programs
  As a Program Director
  I want to ensure programs are created and associated correctly
  So that I can maintain data integrity and relationships

  Scenario: Creating programs
    Given the following programs exist:
      | name    | description                            |
      | SFS     | Scholarship for Service Program        |
      | CLDP    | Community Leadership Development Program |
      | VICEROY | VICEROY Program                        |
    Then I should see the following programs:
      | name    | description                            |
      | SFS     | Scholarship for Service Program        |
      | CLDP    | Community Leadership Development Program |
      | VICEROY | VICEROY Program                        |
