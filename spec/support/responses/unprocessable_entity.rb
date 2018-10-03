# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples_for "unprocessable_entity" do
  it "returns a 422" do
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "has a nice error message" do
    expect(json_response["messages"] || json_response["errors"]).not_to be_blank
  end
end
