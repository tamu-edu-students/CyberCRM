require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    assign(:note, Note.new(
      student: nil,
      note: "MyString",
      followup_action: "MyString",
      action_completed: false,
      is_private: false,
      private_note_user: "MyString",
      status: "MyString"
    ))
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "post" do

      assert_select "input[name=?]", "note[student_id]"

      assert_select "input[name=?]", "note[note]"

      assert_select "input[name=?]", "note[followup_action]"

      assert_select "input[name=?]", "note[action_completed]"

      assert_select "input[name=?]", "note[is_private]"

      assert_select "input[name=?]", "note[private_note_user]"

      assert_select "input[name=?]", "note[status]"
    end
  end
end
