# frozen_string_literal: true

# This is the application helper
module ApplicationHelper
  # rubocop:disable Metrics/MethodLength
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
