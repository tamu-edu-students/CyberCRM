# frozen_string_literal: true

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def login; end
  def spreadsheet; end
  def student_detail; end
  def form; end
  def failure; end

  # before_action :authenticate_user!  # Ensure the user is logged in
  def update_role
    # logger.debug "Params: #{params.inspect}"  # Add this line to debug parameters
    new_role = params[:role]
    sanitized_role_list = current_user.role_list.compact_blank # Remove any empty strings

    if sanitized_role_list.include?(new_role)
      current_user.update(role: new_role)
      flash[:notice] = t('role_updated')
    else
      flash[:alert] = t('role_alert')
    end
    # redirect_to root_path  # Redirect to the homepage or another relevant path
    redirect_back(fallback_location: root_path)
  end

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
