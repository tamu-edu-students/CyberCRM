# app/controllers/notes_controller.rb
class NotesController < ApplicationController
  before_action :set_student
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = @student.notes
  end

  def new
    @note = @student.notes.new
  end

  def create
    @note = @student.notes.new(note_params)

    if @note.save
      redirect_to student_note_path(@student, @note), notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to student_note_path(@student, @note), notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to student_notes_path(@student), notice: 'Note was successfully destroyed.'
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_note
    @note = @student.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:note, :note_created_date, :followup_action, :followup_date, :action_completed, :is_private, :private_note_user, :status)
  end
end
