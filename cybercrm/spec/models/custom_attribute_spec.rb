# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleExpectations

RSpec.describe CustomAttribute do
  describe 'validations' do
    it 'is valid with a name and active status' do
      custom_attribute = described_class.new(name: 'Test Attribute', active: true)
      expect(custom_attribute).to be_valid
    end

    it 'is invalid without a name' do
      custom_attribute = described_class.new(active: true)
      expect(custom_attribute).not_to be_valid
      expect(custom_attribute.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an active status' do
      custom_attribute = described_class.new(name: 'Test Attribute')
      expect(custom_attribute).not_to be_valid
      expect(custom_attribute.errors[:active]).to include('is not included in the list')
    end

    it 'is invalid with a duplicate name' do
      described_class.create(name: 'Unique Name', active: true)
      custom_attribute = described_class.new(name: 'Unique Name', active: true)
      expect(custom_attribute).not_to be_valid
      expect(custom_attribute.errors[:name]).to include('has already been taken')
    end

    it 'is invalid with a name longer than 255 characters' do
      custom_attribute = described_class.new(name: 'a' * 256, active: true)
      expect(custom_attribute).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:student_custom_attributes).dependent(:destroy) }
    it { is_expected.to have_many(:students).through(:student_custom_attributes) }
  end
end
# rubocop:enable RSpec/MultipleExpectations
