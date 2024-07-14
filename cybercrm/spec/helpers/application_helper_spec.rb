# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ApplicationHelper do
  describe '#grade_ryg_class' do
    it "returns 'bg-green-500 text-white' when grade is 'G'" do
      expect(helper.grade_ryg_class('G')).to eq('bg-green-500 text-white')
    end

    it "returns 'bg-red-500 text-white' when grade is 'R'" do
      expect(helper.grade_ryg_class('R')).to eq('bg-red-500 text-white')
    end

    it "returns 'bg-yellow-500 text-black' when grade is 'Y'" do
      expect(helper.grade_ryg_class('Y')).to eq('bg-yellow-500 text-black')
    end

    it "returns an empty string when grade is not 'G', 'R', or 'Y'" do
      expect(helper.grade_ryg_class('A')).to eq('')
      expect(helper.grade_ryg_class(nil)).to eq('')
      expect(helper.grade_ryg_class('')).to eq('')
    end
  end
end
