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
    @students = load_students.where(status: 'Active')
    load_filter_options
  end

  # GET /students/inactive
  def inactive
    @students = load_students.where(status: 'Inactive')
    load_filter_options
  end

  # GET /students/1 or /students/1.json
  def show
    @student = Student.find(params[:id])
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
        save_custom_attributes(@student)
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
    custom_attributes = params[:student].delete(:custom_attributes)

    respond_to do |format|
      if @student.update(student_params)
        save_custom_attributes(@student, custom_attributes)
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

  private

  def load_students
    students = if sort_column && sort_direction
                 Student.order("#{sort_column} #{sort_direction}")
               else
                 Student.all
               end
    apply_filters(students)
  end

  def load_filter_options
    @genders = Student.distinct.pluck(:gender)
    @ethnicities = Student.distinct.pluck(:ethnicity)
    @nationalities = Student.distinct.pluck(:nationality)
    @grades = Student.distinct.pluck(:grade_ryg)
    @classifications = Student.distinct.pluck(:university_classification)
    @statuses = Student.distinct.pluck(:status)
    @orientations = Student.distinct.pluck(:sexual_orientation)
  end

  def apply_filters(students)
    filter_params.each do |key, value|
      next if value.blank?

      students = students.where("#{key} LIKE ?", "%#{value}%")
    end
    students
  end

  def filter_params
    params.permit(:name, :uin, :grade_ryg, :gender, :ethnicity, :nationality, :expected_graduation,
                  :university_classification, :status, :sexual_orientation, :date_of_birth, :email)
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
                                    :sexual_orientation, :date_of_birth, :email, :custom_attributes => {})
  end

  def save_custom_attributes(student, custom_attributes = nil)
    return if custom_attributes.nil?

    custom_attributes.each do |field, value|
      option = Option.find_by(field: field)
      next unless option

      student_option = student.student_options.find_or_initialize_by(option: option)
      student_option.value = value
      Rails.logger.info("\n\n\n\n#{student_option.inspect}\n\n\n\n")
      student_option.save
    end
  end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end
end
