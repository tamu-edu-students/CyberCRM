# frozen_string_literal: true

# Student Helper
module StudentsHelper
    def form_fields
      {
        name: { type: :text },
        uin: { type: :text },
        grade_ryg: { type: :select, options: Student::GRADE_OPTIONS },
        gender: { type: :select, options: Student::GENDER_OPTIONS },
        ethnicity: { type: :select, options: Student::ETHNICITY_OPTIONS },
        nationality: { type: :select, options: Student::NATIONALITY_OPTIONS },
        expected_graduation: { type: :date },
        university_classification: { type: :select, options: Student::UNIVERSITY_CLASSIFICATIONS },
        status: { type: :select, options: Student::STATUS_OPTIONS },
        sexual_orientation: { type: :select, options: Student::SEXUAL_ORIENTATION_OPTIONS },
        date_of_birth: { type: :date },
        email: { type: :text }
      }
    end
  
    def render_field(form, field, options)
      label_tag = form.label field, "#{field.to_s.titleize}:"
      input_tag = case options[:type]
                  when :select
                    form.select field, ['All'] + options[:options], include_blank: true, class: "rounded-lg"
                  when :date
                    form.date_field field, class: "rounded-lg"
                  else
                    form.text_field field, class: "rounded-lg"
                  end
  
      content_tag(:div, label_tag + input_tag)
    end
  end
  