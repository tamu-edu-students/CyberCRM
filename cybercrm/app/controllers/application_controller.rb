# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session[:user_id]

    user = User.find_by(id: session[:user_id])
    @current_user ||= user unless user&.name == 'preloaded'
  end

  protect_from_forgery with: :exception
end
