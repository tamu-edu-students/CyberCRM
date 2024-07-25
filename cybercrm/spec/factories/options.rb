# spec/factories/options.rb

FactoryBot.define do
  factory :option do
    field { "Gender" }
    display_type { "dropdown" }
    options { "Male, Female" }
  end
end
