# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentCustomAttribute do
  let(:student) do
    Student.create(
      name: 'Test Student',
      uin: '123456789',
      grade_ryg: 'G',
      gender: 'Male',
      ethnicity: 'Asian',
      nationality: 'American',
      expected_graduation: '2025-05-15',
      university_classification: 'Junior',
      status: 'Active',
      sexual_orientation: 'Heterosexual',
      date_of_birth: '2000-01-01',
      email: 'test@example.com'
    )
  end

  let(:custom_attribute) { CustomAttribute.create(name: 'Test Attribute', active: true) }

  describe 'validations' do
    it 'is valid with a student, custom attribute, and value' do
      student_custom_attribute = described_class.new(
        student:,
        custom_attribute:,
        value: 'Test Value'
      )
      expect(student_custom_attribute).to be_valid
    end

    it 'is invalid without a student' do
      student_custom_attribute = described_class.new(
        custom_attribute:,
        value: 'Test Value'
      )
      expect(student_custom_attribute).not_to be_valid
      expect(student_custom_attribute.errors[:student]).to include('must exist')
    end

    it 'is invalid without a custom attribute' do
      student_custom_attribute = described_class.new(
        student:,
        value: 'Test Value'
      )
      expect(student_custom_attribute).not_to be_valid
      expect(student_custom_attribute.errors[:custom_attribute]).to include('must exist')
    end

    it 'is invalid without a value' do
      student_custom_attribute = described_class.new(
        student:,
        custom_attribute:
      )
      expect(student_custom_attribute).not_to be_valid
      expect(student_custom_attribute.errors[:value]).to include("can't be blank")
    end

    it 'is invalid with a value longer than 255 characters' do
      student_custom_attribute = described_class.new(
        student:,
        custom_attribute:,
        value: 'a' * 256
      )
      expect(student_custom_attribute).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:custom_attribute) }
  end
end
