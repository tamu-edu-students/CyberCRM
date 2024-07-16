# frozen_string_literal: true

# Students Controller
# rubocop:disable Metrics/ClassLength
class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def search
    @students = search_students(params[:student_search])

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
    @students = filtered_students
  end

  # GET /students/1 or /students/1.json
  def show
    @student = Student.find(params[:id])
    @custom_attributes = CustomAttribute.where(active: true)
  end

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
    return if params[:file].blank?

    process_csv_file(params[:file])
  end

  def update_custom_attribute
    @student = Student.find(params[:id])
    @custom_attribute = CustomAttribute.find(params[:attribute_id])
    student_custom_attribute = @student.student_custom_attributes.find_or_initialize_by(custom_attribute: @custom_attribute)
    student_custom_attribute.value = params[:value]

    if student_custom_attribute.save
      redirect_to @student, notice: I18n.t('attr_updated')
    else
      render :show
    end
  end

  private

  def filtered_students
    students = Student.all
    filter_params.each do |key, value|
      next if value.blank?

      students = if %i[expected_graduation date_of_birth].include?(key)
                   students.where("#{key} = ?", value)
                 else
                   students.where(key => value)
                 end
    end
    students
  end

  def filter_params
    params.permit(:name, :uin, :grade_ryg, :gender, :ethnicity, :nationality, :expected_graduation,
                  :university_classification, :status, :sexual_orientation, :date_of_birth, :email)
  end

  def sort_column_and_direction
    "#{sort_column} #{sort_direction}" if sort_column && sort_direction
  end

  def search_students(query)
    return [] if query.blank?

    Student.where('LOWER(name) LIKE LOWER(?)', "%#{query}%").limit(10)
  end

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
