class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

  @Student
  # GET /notes or /notes.json
  def index
    @notes = Note.first(5)
    tmp = @notes.first
    puts "TMP NOTE= " + tmp.note
    @Student = tmp.student
    puts "TMP STUDENT= " + @Student.name
  end

  def index_student
    @notes = Note.all
  end

  # GET /notes/1 or /notes/1.json
  def show
    puts "----> IN SHOW"
    @student = Student.find(params[:id])
    Rails.logger.debug @student.name
    @notes = @student.notes
    Rails.logger.debug @notes
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  def new2
    render html: 'Hello World!'
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
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
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy!

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:student_id, :note, :note_created_date, :followup_action, :followup_date, :action_completed, :is_private, :private_note_user, :status)
    end
end
