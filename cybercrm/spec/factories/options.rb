# spec/factories/options.rb

FactoryBot.define do
  factory :option do
    sequence(:field) { |n| "field_#{n}" }
    display_type { 'select' }
  end
end
