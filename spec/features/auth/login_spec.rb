# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Login", type: :feature do
  let!(:user) do
    create(:user, first_name: "FIRST_NAME", last_name: "LAST_NAME")
  end
  let(:login_email) { user.email }
  let(:login_password) { user.password }
  let(:starting_page) { "/" }

  before do |example|
    visit starting_page

    unless example.metadata[:skip_before]
      login(email: login_email, password: login_password)
    end
  end

  context "when logged out", :skip_before do
    it "has the login button" do
      expect(page).to have_content "Login"
    end
  end

  context "when valid email/password" do
    it "gives a success message" do
      expect(page).to have_content "Signed in successfully."
    end

    it "has the user's email" do
      expect(page).to have_content login_email
    end

    it "has the user's name" do
      expect(page).to have_content "FIRST_NAME LAST_NAME"
    end

    it "has the logout button" do
      expect(page).to have_content "Logout"
    end

    it "does NOT have the login button" do
      expect(page).not_to have_content "Login"
    end

    context "when a regular user" do
      it "does NOT have the Admin menu" do
        expect(page).not_to have_content "Admin"
      end

      it "redirects to homepage" do
        expect(page).to have_current_path(root_path)
      end
    end

    context "when user is a superadmin" do
      let!(:user) { create(:user, :superadmin) }

      before { visit starting_page }

      it "has the Admin menu" do
        expect(page).to have_content "Admin"
      end

      it "redirects to homepage" do
        expect(page).to have_current_path(root_path)
      end
    end
  end

  context "when valid email (case-insensitive)" do
    let(:login_email) { user.email.upcase }

    it "gives a success message" do
      expect(page).to have_content "Signed in successfully."
    end
  end

  context "when not registered" do
    let(:login_email) { "invalid@example.com" }

    specify { expect(page).to have_content "Invalid Email or password." }
  end

  context "when wrong password" do
    let(:login_password) { "INVALIDPASSWORD" }

    specify { expect(page).to have_content "Invalid Email or password." }
  end
end
