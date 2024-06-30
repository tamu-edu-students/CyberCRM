# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'Student model is valid with required attributes name and uin' do
    student = Student.new( name: 'John Doe', uin: 12345678 )
    expect(student).to be_valid
  end

  it 'Student model is not valid without a name' do
    student = Student.new(uin: 12345678)
    expect(student).to_not be_valid
    expect(student.errors[:name]).to include("can't be blank")
  end
  it 'Student model is not valid without a uin' do
    student = Student.new(name: 'John Doe')
    expect(student).to_not be_valid
    expect(student.errors[:uin]).to include("can't be blank")
  end
end
