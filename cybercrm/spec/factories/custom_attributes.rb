# frozen_string_literal: true

FactoryBot.define do
  factory :custom_attribute do
    name { 'Test Attribute' }
    active { true }
  end
end
