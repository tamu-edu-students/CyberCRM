Feature: Application coverage
  As a developer
  I want to ensure that critical components of the application are executed and covered
  So that the coverage tool reports accurate results

  Scenario: ApplicationJob is tested for retry behavior
    Given I create an instance of ApplicationJob
    When it encounters a deadlock
    Then it should retry the job

  Scenario: ApplicationMailer sends an email
    Given I send a test email using ApplicationMailer
    Then it should send the email successfully
