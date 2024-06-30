# frozen_string_literal: true

Given('I am on the students page') do
  visit students_path
end

When('I click the {string} link') do |link|
  click_link(link)
end

Then('I should receive a file ending in .csv') do
  download_path = Rails.root.join('tmp/downloads')
  downloaded_files = Dir.glob("#{download_path}/*.csv")

  downloaded_files.find { |file| File.extname(file) == '.csv' }
end
