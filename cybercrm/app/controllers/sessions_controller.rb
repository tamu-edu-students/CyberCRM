# frozen_string_literal: true

# This is session controller
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    Rails.logger.debug("OmniAuth data: #{auth.inspect}")

    unless auth
      redirect_to pages_failure_path, alert: "Authentication failed. Please try again."
      return
    end

    user = User.from_omniauth(auth)
    array = ['willtaaa@tamu.edu', 'noamgariani@tamu.edu', 'pcr@tamu.edu', 'john.romero@tamu.edu',
             'pcannell512@tamu.edu', 'matthewatanas@tamu.edu', 'chrisvmuniz@tamu.edu']

    unless array.any? { |token| user.email.include?(token) }
      redirect_to pages_failure_path, alert: I18n.t('failure')
      return
    end

    if ['noamgariani@tamu.edu', 'pcr@tamu.edu', 'willtaaa@tamu.edu'].include?(user.email)
      user.update(role: 'super_user')
    elsif ['john.romero@tamu.edu', 'pcannell512@tamu.edu', 'chrisvmuniz@tamu.edu'].include?(user.email)
      user.update(role: 'program_director')
    else
      user.update(role: 'student_worker')
    end

    session[:user_id] = user.id
    redirect_to pages_home_path, notice: I18n.t('signed_in')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('signed_out')
  end
end
