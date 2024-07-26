require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        student: nil,
        note: "Note",
        followup_action: "Followup Action",
        action_completed: false,
        is_private: false,
        private_note_user: "Private Note User",
        status: "Status"
      ),
      Note.create!(
        student: nil,
        note: "Note",
        followup_action: "Followup Action",
        action_completed: false,
        is_private: false,
        private_note_user: "Private Note User",
        status: "Status"
      )
    ])
  end

  it "renders a list of notes" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Note".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Followup Action".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Private Note User".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
  end
end
