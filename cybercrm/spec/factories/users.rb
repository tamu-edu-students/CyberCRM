# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "john.doe#{n}@example.com" }
    provider { 'google_oauth2' }
    uid { '123545' }
    image { 'http://example.com/image.jpg' }
    role { 'student_worker' }
  end
end
