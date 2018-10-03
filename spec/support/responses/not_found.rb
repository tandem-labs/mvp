# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples_for "not_found" do
  it "returns a 404 response" do
    expect(response.status).to eq(404)
  end

  it "returns an error message" do
    expect(json_response["messages"]).to eq(["Not found"])
  end
end
