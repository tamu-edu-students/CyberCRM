require 'rails_helper'

RSpec.describe "notes/show", type: :view do
  before(:each) do
    assign(:note, Note.create!(
      student: 2,
      note: "Note",
      followup_action: "Followup Action",
      action_completed: false,
      is_private: false,
      private_note_user: "Private Note User",
      status: "Status"
    ))
  end

  # it "renders attributes in <p>" do
  #   render
  #   expect(rendered).to match(//)
  #   expect(rendered).to match(/Note/)
  #   expect(rendered).to match(/Followup Action/)
  #   expect(rendered).to match(/false/)
  #   expect(rendered).to match(/false/)
  #   expect(rendered).to match(/Private Note User/)
  #   expect(rendered).to match(/Status/)
  # end
end
