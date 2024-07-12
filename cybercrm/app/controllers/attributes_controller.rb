# frozen_string_literal: true

# app/controllers/custom_attributes_controller.rb
class CustomAttributesController < ApplicationController
  def index
    @custom_attributes = CustomAttribute.all
  end

  def new
    @custom_attribute = CustomAttribute.new
  end

  def create
    @custom_attribute = CustomAttribute.new(custom_attribute_params)
    if @custom_attribute.save
      redirect_to custom_attributes_path, notice: 'Custom attribute was successfully created.'
    else
      render :new
    end
  end

  def edit
    @custom_attribute = CustomAttribute.find(params[:id])
  end

  def update
    @custom_attribute = CustomAttribute.find(params[:id])
    if @custom_attribute.update(custom_attribute_params)
      redirect_to custom_attributes_path, notice: 'Custom attribute was successfully updated.'
    else
      render :edit
    end
  end

  private

  def custom_attribute_params
    params.require(:custom_attribute).permit(:name, :active)
  end
end
