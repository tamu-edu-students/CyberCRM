# frozen_string_literal: true

namespace :coverage do
  task report: :environment do
    require 'simplecov'

    SimpleCov.collate Dir['coverage/.resultset_*.json'], 'rails' do
      formatter SimpleCov::Formatter::MultiFormatter.new([
                                                           SimpleCov::Formatter::HTMLFormatter,
                                                           SimpleCov::Formatter::JSONFormatter
                                                         ])
    end
  end
end
