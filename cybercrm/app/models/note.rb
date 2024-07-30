# frozen_string_literal: true

# notes model
class Note < ApplicationRecord
  belongs_to :student
end
