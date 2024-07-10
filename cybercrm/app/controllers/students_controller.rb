# frozen_string_literal: true

# Students Controller
# rubocop:disable Metrics/ClassLength
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
    @students = if sort_column && sort_direction
                  Student.order("#{sort_column} #{sort_direction}")
                else
                  Student.all
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

  # POST /students/import
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def import
    if params[:file].present?
      begin
        CSV.foreach(params[:file].path, headers: true) do |row|
          student_attributes = row.to_hash.slice(
            'name', 'uin', 'grade_ryg', 'gender', 'ethnicity', 'nationality', 'expected_graduation',
            'university_classification', 'status', 'sexual_orientation', 'date_of_birth', 'email'
          )

          student = Student.new(student_attributes)

          unless student.save
            redirect_to students_url, alert: "Error saving student: #{student.errors.full_messages.join(', ')}"
            break
          end
        end

        redirect_to students_url, notice: I18n.t('student_imported')
      rescue CSV::MalformedCSVError => e
        redirect_to students_url, alert: "CSV format error: #{e.message}"
      rescue StandardError => e
        redirect_to students_url, alert: "Error importing students: #{e.message}"
      end
    else
      redirect_to students_url, alert: I18n.t('upload_csv')
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  private

  def generate_csv(students)
    CSV.generate(headers: true) do |csv|
      csv << %w[name uin grade_ryg gender ethnicity nationality expected_graduation
                university_classification status sexual_orientation date_of_birth email]

      students.each do |student|
        csv << [student.name, student.uin, student.grade_ryg, student.gender, student.ethnicity,
                student.nationality, student.expected_graduation, student.university_classification,
                student.status, student.sexual_orientation, student.date_of_birth, student.email]
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:name, :uin, :grade_ryg, :gender, :ethnicity, :nationality,
                                    :expected_graduation, :university_classification, :status,
                                    :sexual_orientation, :date_of_birth, :email)
  end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end
end
# rubocop:enable Metrics/ClassLength
