# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/channels/'
end
