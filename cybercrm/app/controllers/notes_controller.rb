# frozen_string_literal: true

# Controls notes. params[:id] is the id of the student
class NotesController < ApplicationController
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
end



  # GET /notes/1/edit
  # def edit; end

  # POST /notes or /notes.json
  # def create
  #   @note = Note.new(note_params)

  #   respond_to do |format|
  #     if @note.save
  #       format.html { redirect_to note_url(@note), notice: 'Note was successfully created.' }
  #       format.json { render :show, status: :created, location: @note }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @note.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /notes/1 or /notes/1.json
  # def update
  #   respond_to do |format|
  #     if @note.update(note_params)
  #       format.html { redirect_to note_url(@note), notice: 'Note was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @note }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @note.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /notes/1 or /notes/1.json
  # def destroy
  #   @note.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private

  # Use callbacks to share common setup or constraints between actions.
  # def set_note
  #   @student = Student.find(params[:id])
  #   puts @student.name
  # end

  # Only allow a list of trusted parameters through.
  # def note_params
  #   params.fetch(:note, {})
  # end

