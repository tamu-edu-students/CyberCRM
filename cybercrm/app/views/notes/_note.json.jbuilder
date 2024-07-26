json.extract! note, :id, :student_id, :note, :note_created_date, :followup_action, :followup_date, :action_completed, :is_private, :private_note_user, :status, :created_at, :updated_at
json.url note_url(note, format: :json)
