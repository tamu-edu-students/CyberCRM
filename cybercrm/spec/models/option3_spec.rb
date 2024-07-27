# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Option do
  describe 'validations' do
    context 'when display_type is dropdown and options are blank' do
      it 'adds an error on options' do
        option = described_class.new(field: 'Field Name', display_type: 'dropdown', options: nil)
        option.validate
        expect(option.errors[:options]).to include("can't be blank for dropdown display type")
      end
    end
  end
end
