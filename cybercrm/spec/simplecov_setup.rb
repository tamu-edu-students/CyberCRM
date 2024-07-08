# frozen_string_literal: true

require 'simplecov'
require 'simplecov-json'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter
])

SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/features/'
end
