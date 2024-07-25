# frozen_string_literal: true

# Student Helper
module StudentsHelper
  def form_fields(student)
    {
      name: { type: :text },
      uin: { type: :text },
      grade_ryg: { type: :select, options: %w[G Y R] },
      gender: { type: :select, options: student.dynamic_genders },
      ethnicity: { type: :select, options: student.dynamic_ethnicities },
      nationality: { type: :select, options: student.dynamic_nationalities },
      expected_graduation: { type: :date },
      university_classification: { type: :select, options: student.dynamic_classifications },
      status: { type: :select, options: student.dynamic_statuses },
      sexual_orientation: { type: :select, options: student.dynamic_orientations },
      date_of_birth: { type: :date },
      email: { type: :text }
    }
  end

  def render_field(form, field, options)
    label_tag = form.label field, "#{field.to_s.titleize}:"
    input_tag = case options[:type]
                when :select
                  form.select field, ['All'] + options[:options], include_blank: true, class: 'rounded-lg'
                when :date
                  form.date_field field, class: 'rounded-lg'
                else
                  form.text_field field, class: 'rounded-lg'
                end

    content_tag(:div, label_tag + input_tag)
  end

  # Method to get the value of a custom attribute
  def custom_attribute_value(student, field)
    option = Option.find_by(field:)
    return nil unless option

    student_option = student.student_options.find_by(option:)
    student_option&.value
  end

  def custom_value(student, field)
    student_option = student.student_options.joins(:option).find_by(options: { field: })
    student_option ? student_option.value : ''
  end
end
