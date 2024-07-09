# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  helper_method :current_user

  before_action :authenticate_user!

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protect_from_forgery with: :exception
end
