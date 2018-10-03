# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "alert_class" do
    [
      ["alert", "alert-warning"],
      ["error", "alert-danger"],
      ["foobar", "alert-foobar"],
      ["notice", "alert-info"],
      ["success", "alert-success"]
    ].each do |flash_type, expected_class|
      describe flash_type do
        specify { expect(alert_class(flash_type)).to eq expected_class }
      end
    end
  end
end
