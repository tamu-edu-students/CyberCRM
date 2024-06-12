# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    array = ['willtaaa@tamu.edu', 'noamgariani@tamu.edu', 'pcr@tamu.edu', 'john.romero@tamu.edu',
             'pcannell512@tamu.edu', 'matthewatanas@tamu.edu', 'chrisvmuniz@tamu.edu']

    unless array.any? { |token| user.email.include?(token) }
      redirect_to root_path, alert: I18n.t('failure')
      return
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: I18n.t('signed_in')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('signed_out')
  end
end
