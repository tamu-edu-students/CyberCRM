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
    @students = Student.all
    @students = @students.by_name(params[:name]) if params[:name].present?
    @students = @students.by_uin(params[:uin]) if params[:uin].present?
    @students = @students.by_grade(params[:grade]) if params[:grade].present?
    @students = @students.by_gender(params[:gender]) if params[:gender].present?
    @students = @students.by_ethnicity(params[:ethnicity]) if params[:ethnicity].present?
    @students = @students.by_nationality(params[:nationality]) if params[:nationality].present?
    @students = @students.by_expected_graduation(params[:expected_graduation]) if params[:expected_graduation].present?
    @students = @students.by_university_classification(params[:university_classification]) if params[:university_classification].present?
    @students = @students.by_status(params[:status]) if params[:status].present?
    @students = @students.by_sexual_orientation(params[:sexual_orientation]) if params[:sexual_orientation].present?
    @students = @students.by_date_of_birth(params[:date_of_birth]) if params[:date_of_birth].present?
    @students = @students.by_email(params[:email]) if params[:email].present?
    
    # Sorting logic remains the same
    @students = @students.order("#{sort_column} #{sort_direction}") if sort_column && sort_direction
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
  def import
    if params[:file].present?
      process_csv_file(params[:file])
    else
      redirect_to students_url
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def process_csv_file(file)
    errors = []

    CSV.foreach(file.path, headers: true) do |row|
      student_attributes = extract_student_attributes(row)
      student = Student.new(student_attributes)

      errors << student.errors.full_messages.join(', ') unless student.save
    end

    if errors.any?
      redirect_to students_url, alert: "Error saving students: #{errors.join(', ')}"
    else
      redirect_to students_url, notice: I18n.t('student_imported')
    end
  end
  # rubocop:enable Metrics/MethodLength

  def extract_student_attributes(row)
    row.to_hash.slice(
      'name', 'uin', 'grade_ryg', 'gender', 'ethnicity', 'nationality', 'expected_graduation',
      'university_classification', 'status', 'sexual_orientation', 'date_of_birth', 'email'
    )
  end

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
                                    :sexual_orientation, :date_of_birth, :email, program_ids: [])
  end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end
end
# rubocop:enable Metrics/ClassLength
