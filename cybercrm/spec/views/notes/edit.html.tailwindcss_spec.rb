require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  let(:note) {
    @student = Student.find(3)
    Note.create!(
      student: @student.id,
      note: "MyString",
      followup_action: "MyString",
      action_completed: false,
      is_private: false,
      private_note_user: nil,
      status: "MyString"
    )
  }

  before(:each) do
    assign(:note, note)
  end

  it "renders the edit note form" do
    render
    #params = {:note_id=>note.id}
    assert_select "form[action=?][method=?]", note_path(note), "post" do #/notes/2/

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
