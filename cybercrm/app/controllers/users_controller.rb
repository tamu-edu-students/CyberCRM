# frozen_string_literal: true

# This is the user controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_super_user

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.provider = 'google_oauth2'
    @user.uid = SecureRandom.uuid
    @user.name = 'preloaded'

    return unless @user.save

    redirect_to @user, notice: I18n.t('created')
  end

  def edit; end

  def update
    return unless @user.update(user_params)

    redirect_to @user, notice: I18n.t('updated')
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: I18n.t('destroyed')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  def authorize_super_user
    return if current_user&.role == 'super_user'

    redirect_to root_path, alert: I18n.t('unauthorized')
  end
end
