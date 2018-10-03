# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  let!(:user) { create(:user) }

  describe "name" do
    let!(:user) { create(:user, first_name: "FIRST", last_name: "LAST") }

    specify { expect(user.name).to eq "FIRST LAST" }
  end

  describe "#role" do
    let!(:user) { create(:user, role) }
    let(:role) { :user }

    context "when has a single role" do
      specify { expect(user.role).to eq "user" }
    end

    context "when has multiple roles" do
      before { user.roles << create(:role, :superadmin) }

      it "uses the most-recently created one" do
        expect(user.role).to eq "superadmin"
      end
    end
  end

  describe "#role=" do
    let!(:user) { create(:user) }

    before do
      %w[superadmin user].each do |role|
        Role.create!(name: role) unless Role.where(name: role).exists?
      end
    end

    context "when has a single role" do
      context "when add a valid role" do
        before { user.role = "superadmin" }

        specify { expect(user.role).to eq "superadmin" }
      end

      context "when add an invalid role" do
        before { user.role = "INVALIDROLE" }

        specify { expect(user.role).to eq "user" }
      end
    end
  end

  describe "superadmin?" do
    before do
      %w[superadmin user].each do |role|
        Role.create!(name: role) unless Role.where(name: role).exists?
      end
    end

    context "when default role" do
      specify { expect(user.superadmin?).to eq false }
    end

    context "when superadmin" do
      before { user.update(role: "superadmin") }

      specify { expect(user.reload.superadmin?).to eq true }
    end
  end

  describe "validations" do
    specify { expect(user.errors).to be_empty }

    specify { expect(user).to validate_presence_of(:first_name) }
    specify { expect(user).to validate_presence_of(:last_name) }

    describe "email" do
      let(:user) { build(:user, email: email) }
      let(:email) { Faker::Internet.email }
      let(:message) { user.errors.messages[:email].first }

      before { user.save }

      context "when missing" do
        let(:email) { nil }

        specify { expect(message).to eq "Please enter a valid email address" }
      end

      context "when invalid" do
        let(:email) { "INVALID EMAIL" }

        specify { expect(message).to eq "Please enter a valid email address" }
      end

      context "when already exists" do
        let(:second_user) { build(:user, email: email) }
        let(:message) { second_user.errors.messages[:email].first }

        before { second_user.save }

        specify do
          expect(message).to eq "This email address is already registered"
        end
      end

      context "when already exists (case-insensitive)" do
        let(:second_user) { build(:user, email: email.upcase) }
        let(:message) { second_user.errors.messages[:email].first }

        before { second_user.save }

        specify do
          expect(message).to eq "This email address is already registered"
        end
      end
    end

    describe "password" do
      let(:user) { build(:user, password: password) }
      let(:password) { Faker::Internet.password }
      let(:message) { user.errors.messages[:password].first }

      before { user.save }

      context "when missing" do
        let(:password) { nil }

        specify { expect(message).to eq "Please enter a password" }
      end

      context "when too short" do
        let(:password) { "pass" }

        specify do
          expect(message).to(
            include("Passwords must be longer than 6 characters")
          )
        end
      end

      context "when too long" do
        let(:password) { (1..129).to_a.join("") }

        specify { expect(message).to include "is too long" }
      end
    end

    describe "password_confirmation" do
      let(:user) do
        build(
          :user,
          password: password,
          password_confirmation: password_confirmation
        )
      end
      let(:password) { Faker::Internet.password }
      let(:password_confirmation) { password }
      let(:message) { user.errors.messages[:password_confirmation].first }

      before { user.save }

      context "when password is set" do
        context "when confirmation is set" do
          specify { expect(message).to be_blank }
        end

        context "when confirmation is blank" do
          let(:password_confirmation) { nil }

          specify { expect(message).to eq "Please confirm your new password" }
        end
      end

      context "when password is blank" do
        let(:password) { nil }

        context "when confirmation is blank" do
          let(:password_confirmation) { nil }

          specify { expect(message).to be_blank }
        end
      end
    end
  end
end
