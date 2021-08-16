RSpec.describe DataBroker, type: :model do
  describe "attributes" do
    subject(:instance) do
      described_class.new(
        name: "lol",
        url: "lol.com",
        opt_out_url: "lol.com/lmao",
        opt_out_type: "form",
        notes: nil,
      )
    end

    it "has the right attributes" do
      expect(instance).to have_attributes(
        name: "lol",
        url: "lol.com",
        opt_out_url: "lol.com/lmao",
        opt_out_type: "form",
        notes: nil,
      )
    end
  end

  describe "constants" do
    it "has opt out types" do
      expect(described_class::OptOutTypes).to contain_exactly("form")
    end

    it "has valid providers" do
      expect(described_class::Providers).to contain_exactly(
        "spokeo",
        "peekyou",
        "pipl",
        "whitepages",
        "epsilon_data_management",
      )
    end
  end

  describe "relations" do
    it { is_expected.to have_many(:user_data_brokers) }
    it { is_expected.to have_many(:users).through(:user_data_brokers) }
  end
end
