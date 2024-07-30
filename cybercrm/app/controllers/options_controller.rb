# frozen_string_literal: true

class OptionsController < ApplicationController
  before_action :set_option, only: %i[edit update destroy]
  before_action :set_fields, only: %i[new edit create update]

  def index
    @options = Option.all
    @student_fields = {
      'Gender' => %w[Male Female] + Option.where(field: 'Gender').pluck(:options),
      'Ethnicity' => ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'] +
                     Option.where(field: 'Ethnicity').pluck(:options),
      'Nationality' => %w[American British Canadian Australian French German Japanese Chinese Indian Other] +
                       Option.where(field: 'Nationality').pluck(:options),
      'University Classification' => %w[Freshman Sophomore Junior Senior Graduate] +
                                     Option.where(field: 'University Classification').pluck(:options),
      'Sexual Orientation' => %w[Heterosexual Homosexual] +
                              Option.where(field: 'Sexual Orientation').pluck(:options)
    }
  end

  def new
    @option = Option.new
  end

  def edit
    @option = Option.find(params[:id])
  end

  def create
    if params[:option][:field] == 'New Field'
      params[:option][:field] = params[:option][:new_field]
      params[:option].delete(:new_field)
    end

    existing_option = Option.find_by(field: params[:option][:field], display_type: params[:option][:display_type])

    if existing_option
      new_options = params[:option][:options].split(',').map(&:strip)
      updated_options = (existing_option.options.split(',').map(&:strip) + new_options).uniq.join(', ')

      if existing_option.update(options: updated_options)
        redirect_to options_path, notice: 'Option was successfully updated.'
      else
        @option = existing_option
        flash.now[:alert] = existing_option.errors.full_messages.to_sentence
        render :new
      end
    else
      params[:option].delete(:new_field)
      @option = Option.new(option_params)
      if @option.save
        redirect_to options_path, notice: 'Option was successfully created.'
      else
        render :new
      end
    end
  end

  def update
    if params[:option][:field] == 'New Field'
      params[:option][:field] = params[:option][:new_field]
      params[:option].delete(:new_field)
    end

    existing_option = Option.find_by(field: params[:option][:field], display_type: params[:option][:display_type])

    if existing_option && existing_option != @option
      new_options = params[:option][:options].split(',').map(&:strip)
      updated_options = (existing_option.options.split(',').map(&:strip) + new_options).uniq.join(', ')
      if existing_option.update(options: updated_options)
        @option.destroy
        redirect_to options_path, notice: 'Option was successfully updated.'
      else
        @option = existing_option
        flash.now[:alert] = existing_option.errors.full_messages.to_sentence
        render :edit
      end
    else
      params[:option].delete(:new_field)
      if @option.update(option_params)
        redirect_to options_path, notice: 'Option was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @option.destroy
    redirect_to options_path, notice: 'Option was successfully destroyed.'
  end

  def add_option_to_field
    field = params[:option][:field]
    new_option = params[:option][:options].strip

    if field.present? && new_option.present?
      option = Option.find_by(field:, display_type: 'dropdown')

      if option
        existing_options = option.options.split(',').map(&:strip)
        if existing_options.include?(new_option)
          redirect_to options_path, alert: 'Option already exists.'
        else
          updated_options = (existing_options + [new_option]).join(', ')
          if option.update(options: updated_options)
            redirect_to options_path, notice: 'Option was successfully updated.'
          else
            redirect_to options_path, alert: option.errors.full_messages.to_sentence
          end
        end
      else
        option = Option.new(field:, display_type: 'dropdown', options: new_option)
        if option.save
          redirect_to options_path, notice: 'Option was successfully created.'
        else
          redirect_to options_path, alert: option.errors.full_messages.to_sentence
        end
      end
    else
      redirect_to options_path, alert: 'Field and new option must be present.'
    end
  end

  private

  def set_option
    @option = Option.find(params[:id])
  end

  def set_fields
    @fields = ['Gender', 'Ethnicity', 'Nationality', 'University Classification', 'Sexual Orientation'] +
              Option.distinct.pluck(:field)
  end

  def option_params
    params.require(:option).permit(:field, :name, :display_type, :options, :new_field)
  end
end
