# frozen_string_literal: true

# This is the application helper
module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    current_direction = params[:sort] == column ? params[:direction] : nil
    new_direction = case current_direction
                    when nil then "asc"
                    when "asc" then "desc"
                    else nil
                    end

    arrow = case current_direction
            when "asc" then "↑"
            when "desc" then "↓"
            else ""
            end

    link_to "#{title} #{arrow}".html_safe, { sort: column, direction: new_direction }, class: "sortable"
  end

  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
