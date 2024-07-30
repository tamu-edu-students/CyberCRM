# spec/factories/notes.rb
FactoryBot.define do
    factory :note do
      note { "Follow up note" }
      note_created_date { Date.today }
      followup_action { "Follow up action" }
      followup_date { Date.today + 1.week }
      action_completed { false }
      status { "Active" }
      association :student
    end
  end
  