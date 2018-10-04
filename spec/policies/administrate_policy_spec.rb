# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdministratePolicy do
  let!(:policy) { described_class.new(user, :administrate) }
  let!(:user) { create(:user, role) }
  let(:role) { :user }

  context "when user is nil" do
    let!(:user) { nil }

    specify { expect(policy).to forbid_action(:administrate) }
  end

  context "when a regular user" do
    let(:role) { :user }

    specify { expect(policy).to forbid_action(:administrate) }
  end

  context "when a superadmin" do
    let(:role) { :superadmin }

    specify { expect(policy).to permit_action(:administrate) }
  end
end
