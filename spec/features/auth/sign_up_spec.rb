# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Signup", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:password) { Faker::Internet.password }
  let(:password_confirmation) { password }

  def sign_up!
    sign_up(
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation
    )
  end

  before do |example|
    sign_up! unless example.metadata[:skip_before]
  end

  context "with valid params" do
    let(:user) { User.find_by(email: email) }

    it "creates a new user", :skip_before do
      expect { sign_up! }.to change(User, :count).by(1)
    end

    describe "created user" do
      specify { expect(user.email).to eq email }
      specify { expect(user.first_name).to eq first_name }
      specify { expect(user.last_name).to eq last_name }
    end

    it "redirects them to the home page" do
      expect(page).to have_current_path root_path
    end
  end

  context "when email already exists", :skip_before do
    let!(:existing_user) { create(:user, email: email) }

    before { sign_up! }

    specify do
      expect(page).to have_content "This email address is already registered"
    end
  end

  context "when email missing" do
    let!(:email) { nil }

    specify do
      expect(page).to have_content "Please enter a valid email address"
    end
  end

  context "when password missing" do
    let!(:password) { nil }

    specify { expect(page).to have_content "Please enter a password" }
  end

  context "when first_name missing" do
    let!(:first_name) { nil }

    specify { expect(page).to have_content "Please enter your first name" }
  end

  context "when last_name missing" do
    let!(:last_name) { nil }

    specify { expect(page).to have_content "Please enter your last name" }
  end
end
