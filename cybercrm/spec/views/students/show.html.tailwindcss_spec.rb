# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/show' do
  before do
    assign(:student, Student.create!(
                       name: 'Name',
                       age: 2,
                       grade: 'Grade',
                       uin: 3,
                       gpa: '9.99',
                       gender: 'Gender',
                       ethnicity: 'Ethnicity',
                       nationality: 'Nationality',
                       university_classification: 'University Classification'
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Grade/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Ethnicity/)
    expect(rendered).to match(/Nationality/)
    expect(rendered).to match(/University Classification/)
  end
end
