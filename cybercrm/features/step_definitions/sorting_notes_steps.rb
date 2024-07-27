# frozen_string_literal: true

Then('I should see notes sorted by {string} in ascending order') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym)
  sorted_notes.each_with_index do |note, index|
    expect(page.all('tbody tr')[index]).to have_content(note[column_name.parameterize.underscore.to_sym])
  end
end

Then('I should see notes sorted by {string} in descending order') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym => :desc)
  sorted_notes.each_with_index do |note, index|
    expect(page.all('tbody tr')[index]).to have_content(note[column_name.parameterize.underscore.to_sym])
  end
end

Then('I should see notes sorted by {string} in the default order') do |column_name|
  Note.all.each_with_index do |note, index|
    expect(page.all('tbody tr')[index]).to have_content(note[column_name.parameterize.underscore.to_sym])
  end
end
