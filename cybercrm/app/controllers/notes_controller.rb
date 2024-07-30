class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update  ] #destroy
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
    @notes = @student.notes.where(status: "Active")
    Rails.logger.debug @notes

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
    @student = Student.find(params[:student_id])
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:note_id])
    @student = Student.find(@note.student_id) 
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    @note.status = "Active"
    @note.note_created_date = Date.today
    puts @note.status
    @student = @note.student
    if @note.private_note_user == ""
      @note.private_note_user = nil
    end
    respond_to do |format|
      if @note.save
        format.html { redirect_to "/notes/" + @note.student_id.to_s} 
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to "/notes/" + @note.student_id.to_s, notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:student_id, :note, :note_created_date, :followup_action, :followup_date, :action_completed, :is_private, :private_note_user, :status)
    end
end
