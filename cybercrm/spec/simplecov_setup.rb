# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.start 'rails' do
  minimum_coverage 90
  add_filter '/spec/'
  add_filter '/channels/'
end
