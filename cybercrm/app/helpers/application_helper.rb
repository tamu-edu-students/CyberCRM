# frozen_string_literal: true

# This is the application helper
module ApplicationHelper
  # rubocop:disable Metrics/MethodLength
  def grade_ryg_class(grade)
    case grade
    when 'G'
      'bg-green-500 text-white'
    when 'R'
      'bg-red-500 text-white'
    when 'Y'
      'bg-yellow-500 text-black'
    else
      ''
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    current_direction = params[:sort] == column ? params[:direction] : nil
    new_direction = case current_direction
                    when nil then 'asc'
                    when 'asc' then 'desc'
                    end

    arrow = case current_direction
            when 'asc' then '↑'
            when 'desc' then '↓'
            else ''
            end

    link_to "#{title} #{arrow}", { sort: column, direction: new_direction }, class: 'sortable'
  end
  # rubocop:enable Metrics/MethodLength
end
