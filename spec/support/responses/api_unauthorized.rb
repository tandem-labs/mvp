# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples_for "api unauthorized" do
  it "returns an error message" do
    expect(json_response["errors"]).to(
      eq(["You need to sign in or sign up before continuing."])
    )
  end

  it "returns a 401 unauthorized status code" do
    expect(response).to have_http_status(:unauthorized)
  end
end
