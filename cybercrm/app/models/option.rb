# frozen_string_literal: true

# app/models/option.rb
class Option < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :option_type }
  validates :option_type, presence: true
  validates :display_type, presence: true
end
