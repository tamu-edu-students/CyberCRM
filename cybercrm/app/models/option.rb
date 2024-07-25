# frozen_string_literal: true

# app/models/option.rb

# Option
class Option < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :option_type }, length: { maximum: 255 }
  validates :option_type, presence: true
  validates :display_type, presence: true
end
