# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples_for "ok" do
  it "returns success" do
    expect(response).to have_http_status(:ok)
  end
end
