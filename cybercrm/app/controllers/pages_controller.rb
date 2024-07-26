# frozen_string_literal: true

# Controls the pages
class PagesController < ApplicationController
  def login; end
  def home; end
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
end
