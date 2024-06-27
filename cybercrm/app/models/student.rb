# frozen_string_literal: true

class Student < ApplicationRecord
  validates :uin, :name, presence: true
end
