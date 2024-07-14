# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  it 'is valid with name, uin, and all required attributes' do
    student = described_class.new(
      name: 'John Doe',
      uin: 123_456_789,
      grade_ryg: 'G',
      gender: 'Male',
      ethnicity: 'White',
      nationality: 'American',
      expected_graduation: '2025-05-01',
      university_classification: 'Senior',
      status: 'Active',
      sexual_orientation: 'Heterosexual',
      date_of_birth: '1990-01-01',
      email: 'john.doe@example.com'
    )
    expect(student).to be_valid
  end
end
