require 'rails_helper'

RSpec.describe DataBroker, type: :model do
  describe "attributes" do
    subject do
      described_class.new(
        name: "lol",
        url: "lol.com",
        opt_out_url: "lol.com/lmao",
        opt_out_type: "form",
        notes: nil,
      )
    end

    it {
      is_expected.to have_attributes(
        name: "lol",
        url: "lol.com",
        opt_out_url: "lol.com/lmao",
        opt_out_type: "form",
        notes: nil,
      )
    }
  end

  describe "constants" do
    it "has opt out types" do
      expect(described_class::OptOutTypes).to contain_exactly("form")
    end
  end
end
