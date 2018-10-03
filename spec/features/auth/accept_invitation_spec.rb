# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Accept Invitation", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:password) { Faker::Internet.password }
  let(:password_confirmation) { password }

  def accept_invitation!
    user = User.invite!(email: email)

    accept_invitation(
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation,
      user: user
    )
  end

  before do |example|
    accept_invitation! unless example.metadata[:skip_before]
  end

  context "with valid params" do
    let(:user) { User.find_by(email: email) }

    describe "user after accepting" do
      specify { expect(user.reload.email).to eq email }
      specify { expect(user.reload.first_name).to eq first_name }
      specify { expect(user.reload.last_name).to eq last_name }
    end

    it "redirects them to the home page" do
      expect(page).to have_current_path root_path
    end

    it "logs them in" do
      expect(page).to have_content "Logout"
    end
  end

  context "when first_name missing" do
    let!(:first_name) { nil }

    specify { expect(page).to have_content "Please enter your first name" }
  end

  context "when last_name missing" do
    let!(:last_name) { nil }

    specify { expect(page).to have_content "Please enter your last name" }
  end

  context "when password missing" do
    let!(:password) { nil }

    specify { expect(page).to have_content "Please enter a password" }
  end

  context "when password confirmation missing" do
    let!(:password_confirmation) { nil }

    specify { expect(page).to have_content "Please confirm your new password" }
  end
end
