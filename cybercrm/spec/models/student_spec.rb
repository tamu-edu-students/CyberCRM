# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  it 'Student is valid with name and uin' do
    student = described_class.new(name: 'John Doe', uin: 12_345_678)
    expect(student).to be_valid
  end

  # rubocop:disable RSpec/MultipleExpectations
  it 'Student invalid without name' do
    student = described_class.new(uin: 12_345_678)
    expect(student).not_to be_valid
    expect(student.errors[:name]).to include("can't be blank")
  end

  it 'Student invalid without uin' do
    student = described_class.new(name: 'John Doe')
    expect(student).not_to be_valid
    expect(student.errors[:uin]).to include("can't be blank")
  end
  # rubocop:enable RSpec/MultipleExpectations
end
