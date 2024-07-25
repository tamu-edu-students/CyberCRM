# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def login; end

  def home
    @attribute = params[:attribute] || 'gender'
    @chart_type = params[:chart_type] || 'bar'
    @chart_data = fetch_chart_data(@attribute)
    @attributes = %w[gender ethnicity nationality university_classification status sexual_orientation grade_ryg]
    @chart_types = %w[bar line pie column]
  end

  private

  def fetch_chart_data(attribute)
    case attribute
    when 'gender'
      Student.group(:gender).count
    when 'ethnicity'
      Student.group(:ethnicity).count
    when 'nationality'
      Student.group(:nationality).count
    when 'university_classification'
      Student.group(:university_classification).count
    when 'status'
      Student.group(:status).count
    when 'sexual_orientation'
      Student.group(:sexual_orientation).count
    when 'grade_ryg'
      Student.group(:grade_ryg).count
    end
  end
end
