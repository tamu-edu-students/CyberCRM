# frozen_string_literal: true

# app/models/option.rb
class Option < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :display_type, presence: true
end
