# frozen_string_literal: true

# app/controllers/options_controller.rb
class OptionsController < ApplicationController
  before_action :set_option, only: %i[edit update destroy]

  def index
    @options = Option.where.not(option_type: 'CustomAttribute')
    @custom_attributes = Option.where(option_type: 'CustomAttribute')
    @student_fields = {
      'Gender' => %w[Male Female] + Option.where(option_type: 'Gender').pluck(:name),
      'Ethnicity' => ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White',
                      'Other'] + Option.where(option_type: 'Ethnicity').pluck(:name),
      'Nationality' => %w[American British Canadian Australian French German Japanese Chinese
                          Indian Other] + Option.where(option_type: 'Nationality').pluck(:name),
      'University Classification' => %w[Freshman Sophomore Junior Senior
                                        Graduate] + Option.where(option_type: 'University Classification').pluck(:name),
      'Status' => %w[Active Inactive] + Option.where(option_type: 'Status').pluck(:name),
      'Sexual Orientation' => %w[Heterosexual
                                 Homosexual] + Option.where(option_type: 'Sexual Orientation').pluck(:name)
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
    params.require(:option).permit(:name, :option_type, :display_type)
  end
end
