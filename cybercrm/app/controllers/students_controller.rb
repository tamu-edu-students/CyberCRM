# frozen_string_literal: true

require 'csv'

# Student Controller
class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  # GET /students or /students.json
  def index
    @students = Student.all
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
        format.html { redirect_to student_url(@student), notice: 'Student was successfully created.' }
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
        format.html { redirect_to student_url(@student), notice: 'Student was successfully updated.' }
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
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /students/export_csv
  def export_csv
    @students = Student.all
    send_data generate_csv(@students), filename: "students-#{Time.zone.today}.csv"
  end

  private

  def generate_csv(students)
    CSV.generate(headers: true) do |csv|
      csv << ['Name', 'Age', 'Grade', 'UIN', 'GPA', 'Gender', 'Ethnicity', 'Nationality', 'Expected Graduation',
              'University Classification']

      students.each do |student|
        csv << [student.name, student.age, student.grade, student.uin, student.gpa, student.gender, student.ethnicity,
                student.nationality, student.expected_graduation, student.university_classification]
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:name, :age, :grade, :uin, :gpa, :gender, :ethnicity, :nationality,
                                    :expected_graduation, :university_classification)
  end
end