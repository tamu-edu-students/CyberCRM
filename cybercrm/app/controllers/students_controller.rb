# frozen_string_literal: true

require 'csv'

# Student Controller
class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def search
    @students = if params[:student_search].present?
                  Student.where('LOWER(name) LIKE LOWER(?)', "%#{params[:student_search]}%").limit(10)
                else
                  []
                end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'search_results',
          partial: 'students/search_results',
          locals: { students: @students }
        )
      end
    end
  end

  # GET /students or /students.json
  def index
    if sort_column && sort_direction
      @students = Student.order("#{sort_column} #{sort_direction}")
    else
      @students = Student.all
    end
  end

  # GET /students/1 or /students/1.json
  def show; end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit; end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: I18n.t('student_created') }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: I18n.t('student_updated') }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: I18n.t('student_deleted') }
      format.json { head :no_content }
    end
  end

  # GET /students/export_csv
  def export_csv
    @students = Student.all
    send_data generate_csv(@students), filename: "students-#{Time.zone.today}.csv"
  end

  private

  # rubocop:disable Metrics/AbcSize
  def generate_csv(students)
    CSV.generate(headers: true) do |csv|
      csv << ['Name', 'UIN', 'Grade', 'Gender', 'Ethnicity', 'Nationality', 'Expected Graduation',
              'University Classification', 'Status', 'Sexual Orientation', 'Date of Brirth',
              'Internships', 'Corps', 'Security Clearance']

      students.each do |student|
        csv << [student.name, student.uin, student.grade_ryg, student.gender, student.ethnicity,
                student.nationality, student.expected_graduation, student.university_classification,
                student.status, student.sexual_orientation, student.date_of_birth, student.internships,
                student.corps, student.security_clearance]
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:name, :age, :grade, :uin, :gpa, :gender, :ethnicity, :nationality,
                                    :expected_graduation, :university_classification)
  end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end
end
