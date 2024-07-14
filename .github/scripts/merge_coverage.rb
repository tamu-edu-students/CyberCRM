#!/usr/bin/env ruby
require 'simplecov'

SimpleCov.collate Dir["coverage/*/.resultset.json"] do
  SimpleCov.formatter SimpleCov::Formatter::HTMLFormatter
  SimpleCov.minimum_coverage 90
end
