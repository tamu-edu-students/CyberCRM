# frozen_string_literal: true

# This is session controller
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to pages_home_path, notice: I18n.t('signed_in')
    else
      handle_user_failure
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('signed_out')
  end

  private

  def handle_user_failure
    array = ['willtaaa@tamu.edu', 'noamgariani@tamu.edu', 'pcr@tamu.edu', 'john.romero@tamu.edu',
             'pcannell512@tamu.edu', 'matthewatanas@tamu.edu', 'chrisvmuniz@tamu.edu',
             'john.doe@example.com']

    return if array.any? { |token| @user.email.include?(token) }

    redirect_to root_path, alert: I18n.t('failure')
  end
end
