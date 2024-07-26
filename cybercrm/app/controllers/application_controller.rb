# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  before_action :set_audited_user
  helper_method :current_user

  def current_user
    return unless session[:user_id]

    user = User.find_by(id: session[:user_id])
    @current_user ||= user unless user&.name == 'preloaded'
  end

  protect_from_forgery with: :exception

  private

  def set_audited_user
    Audited.current_user_method = :current_user
  end
end
