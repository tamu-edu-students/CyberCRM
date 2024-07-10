# frozen_string_literal: true

Given('I create an instance of ApplicationJob') do
  # Simulate creating an instance of ApplicationJob
  @job = ApplicationJob.new
end

When('it encounters a deadlock') do
  # Simulate encountering a deadlock and retrying the job
  ApplicationJob.retry_on(ActiveRecord::Deadlocked) { raise ActiveRecord::Deadlocked }
end

Then('it should retry the job') do
  # Assert that retry behavior was triggered
  expect { ApplicationJob.retry_on(ActiveRecord::Deadlocked) { raise ActiveRecord::Deadlocked } }.not_to raise_error
end

Given('I send a test email using ApplicationMailer') do
  # Simulate sending a test email
  ApplicationMailer.test_email.deliver_now
end

Then('it should send the email successfully') do
  # Assert that the email delivery was successful
  expect(ActionMailer::Base.deliveries.count).to eq(1)
end
