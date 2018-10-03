# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Logout", type: :feature do
  let!(:user) { create(:user) }

  before { login(email: user.email, password: user.password) }

  context "when click logout button" do
    before { logout }

    it "redirects to the home page" do
      expect(page).to have_current_path(root_path)
    end

    it "gives a success message" do
      expect(page).to have_content "Signed out successfully."
    end

    it "does NOT have the user's email" do
      expect(page).not_to have_content user.email
    end

    it "does NOT have the logout button" do
      expect(page).not_to have_content "Logout"
    end

    it "has the login button" do
      expect(page).to have_content "Login"
    end
  end
end
