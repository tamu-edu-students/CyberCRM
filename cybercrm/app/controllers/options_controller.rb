# app/controllers/options_controller.rb
class OptionsController < ApplicationController
  before_action :set_option, only: %i[edit update destroy]

  def index
    @options = Option.all
    @student_fields = {
      'Gender' => %w[Male Female] + Option.where(display_type: 'dropdown').pluck(:name),
      'Ethnicity' => ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'] + Option.where(display_type: 'dropdown').pluck(:name),
      'Nationality' => %w[American British Canadian Australian French German Japanese Chinese Indian Other] + Option.where(display_type: 'dropdown').pluck(:name),
      'University Classification' => %w[Freshman Sophomore Junior Senior Graduate] + Option.where(display_type: 'dropdown').pluck(:name),
      'Status' => %w[Active Inactive] + Option.where(display_type: 'dropdown').pluck(:name),
      'Sexual Orientation' => %w[Heterosexual Homosexual] + Option.where(display_type: 'dropdown').pluck(:name)
    }
  end

  def new
    @option = Option.new
  end

  def edit; end

  def create
    @option = Option.new(option_params)
    if @option.save
      redirect_to options_path, notice: 'Option was successfully created.'
    else
      Rails.logger.debug "Option not created: #{@option.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def update
    if @option.update(option_params)
      redirect_to options_path, notice: 'Option was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @option.destroy
    redirect_to options_path, notice: 'Option was successfully destroyed.'
  end

  private

  def set_option
    @option = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(:name, :display_type)
  end
end
