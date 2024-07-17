# frozen_string_literal: true

# app/controllers/custom_attributes_controller.rb
class CustomAttributesController < ApplicationController
  def index
    @custom_attributes = CustomAttribute.all
  end

  def new
    @custom_attribute = CustomAttribute.new
  end

  def edit
    @custom_attribute = CustomAttribute.find(params[:id])
  end

  def create
    @custom_attribute = CustomAttribute.new(custom_attribute_params)
    return unless @custom_attribute.save

    redirect_to custom_attributes_path, notice: I18n.t('attr_created')
  end

  def update
    @custom_attribute = CustomAttribute.find(params[:id])
    return unless @custom_attribute.update(custom_attribute_params)

    redirect_to custom_attributes_path, notice: I18n.t('attr_updated')
  end

  def toggle_active
    @custom_attribute = CustomAttribute.find(params[:id])
    @custom_attribute.update(active: !@custom_attribute.active)
    redirect_to custom_attributes_path, notice: I18n.t('attr_updated')
  end

  private

  def custom_attribute_params
    params.require(:custom_attribute).permit(:name, :active)
  end
end
