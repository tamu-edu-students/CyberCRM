# frozen_string_literal: true

Given('I am on the students page') do
  visit students_path
end

When('I click the {string} link') do |link|
  click_on link
end

Then('I should receive a file ending in .csv') do
  download_path = Rails.root.join('tmp/downloads')
  downloaded_files = Dir.glob("#{download_path}/*.csv")

  downloaded_files.find { |file| File.extname(file) == '.csv' }
end

When('I click the {string} button') do |button|
  click_link_or_button button
end

Then('I should receive a CSV file with the following content:') do |table|
  csv_content = CSV.parse(page.body)
  table.hashes.each_with_index do |row, index|
    row.each_value do |value|
      expect(csv_content[index + 1]).to include(value)
    end
  end
end
