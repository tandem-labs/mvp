# frozen_string_literal: true

require "rails_helper"

RSpec.describe Role, type: :model do
  before { %w[superadmin user].each { |r| create(:role, name: r) } }

  describe "defaults" do
    let!(:user) { create(:user) }

    specify { expect(user.has_role?(:superadmin)).to eq false }
    specify { expect(user.has_role?(:user)).to eq true }
  end

  describe "slug" do
    let(:superadmin) { Role.find_by(name: "superadmin") }
    let(:user) { Role.find_by(name: "user") }

    specify { expect(superadmin.slug).to eq :superadmin }
    specify { expect(user.slug).to eq :user }
  end
end
