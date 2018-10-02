# frozen_string_literal: true

RSpec.describe "Sanity Check" do
  context "when true" do
    let(:value) { true }

    it "equals true" do
      expect(value).to eq true
    end
  end
end
