# frozen_string_literal: true

# Program model to represent different programs and their details.
# A program can be things like a VICEROY Program.
class Program < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
