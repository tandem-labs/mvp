# frozen_string_literal: true

# rubocop:disable all

# Author Shiva Bhusal
# Aug 2016
# in config/initializers/modify_rails_form_builder.rb
# This will add a new method in the `f` object available in Rails forms
# https://stackoverflow.com/a/38923317
class ActionView::Helpers::FormBuilder
  def error_message_for(field_name)
    if self.object.errors[field_name].present?
      model_name = self.object.class.name.downcase
      id_of_element = "error_#{model_name}_#{field_name}"
      target_elem_id = "#{model_name}_#{field_name}"
      class_name = "error-message"
      full_error_message = self.object.errors[field_name]

      "<div id=\"#{id_of_element}\" for=\"#{target_elem_id}\" class=\"#{class_name}\">"\
      "  #{full_error_message.join('<br />')}"\
      "</div>".html_safe
    end
  rescue
    nil
  end
end
# rubocop:enable
