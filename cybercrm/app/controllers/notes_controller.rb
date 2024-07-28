# app/controllers/notes_controller.rb
# frozen_string_literal: true

class NotesController < ApplicationController
  # GET /notes
  def index
    @notes = Note.all

    if params[:note_created_date].present?
      @notes = @notes.where(note_created_date: params[:note_created_date])
    end
    if params[:note].present?
      @notes = @notes.where("note LIKE ?", "%#{params[:note]}%")
    end
    if params[:followup_date].present?
      @notes = @notes.where(followup_date: params[:followup_date])
    end
    if params[:followup_action].present?
      @notes = @notes.where("followup_action LIKE ?", "%#{params[:followup_action]}%")
    end
    if params[:action_completed].present?
      @notes = @notes.where(action_completed: params[:action_completed])
    end

    sort_column = params[:sort] || 'note_created_date'
    sort_direction = params[:direction] || 'asc'
    @notes = @notes.order("#{sort_column} #{sort_direction}")
  end

  # GET /notes/1 or /notes/1.json
  def show
    @student = Student.find(params[:id])
    Rails.logger.debug @student.name
    @notes = @student.notes

    if params[:note_created_date].present?
      @notes = @notes.where(note_created_date: params[:note_created_date])
    end
    if params[:note].present?
      @notes = @notes.where("note LIKE ?", "%#{params[:note]}%")
    end
    if params[:followup_date].present?
      @notes = @notes.where(followup_date: params[:followup_date])
    end
    if params[:followup_action].present?
      @notes = @notes.where("followup_action LIKE ?", "%#{params[:followup_action]}%")
    end
    if params[:action_completed].present?
      @notes = @notes.where(action_completed: params[:action_completed])
    end

    sort_column = params[:sort] || 'note_created_date'
    sort_direction = params[:direction] || 'asc'
    @notes = @notes.order("#{sort_column} #{sort_direction}")
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # Other actions (edit, create, update, destroy) are commented out, if needed you can uncomment them and use them as required.
end
