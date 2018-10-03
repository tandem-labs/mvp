# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Reset Password", type: :feature do
  let!(:user) { create(:user) }
  let(:email) { user.email }

  before { reset_password(email: email) }

  context "with a valid email" do
    it "sends an email to the email address" do
      expect(page).to have_content(
        "We have sent you an email with a link to reset your password."
      )
    end
  end

  context "with an invalid email" do
    let(:email) { "invalid@example.com" }

    it "still 'sends' an email but does not tell the user it was wrong" do
      expect(page).to have_content(
        "We have sent you an email with a link to reset your password."
      )
    end
  end

  context "with a blank email" do
    let(:email) { nil }

    it "still 'sends' an email but does not tell the user it was wrong" do
      expect(page).to have_content(
        "We have sent you an email with a link to reset your password."
      )
    end
  end
end
