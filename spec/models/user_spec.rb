RSpec.describe User, type: :model do
  describe "attributes" do
    let(:instance) do
      described_class.new(
        first_name: "Roger",
        last_name: "Klotz",
        state: "PA",
        email: "roger.klotz@gmail.com",
        age: 25,
      )
    end

    it "has all the correct attributes" do
      expect(instance).to have_attributes(
        first_name: "Roger",
        last_name: "Klotz",
        state: "PA",
        email: "roger.klotz@gmail.com",
        age: 25,
      )
    end
  end

  describe "encrypted attributes" do
    let(:instance) do
      described_class.new(
        first_name: "Roger",
        last_name: "Klotz",
        state: "PA",
        email: "roger.klotz@gmail.com",
        age: 25,
      )
    end

    before do
      instance.save!
    end

    context "with a blind index" do
      it "are searchable" do
        result = described_class.find_by(
          first_name: "Roger",
          last_name: "Klotz",
          email: "roger.klotz@gmail.com",
        )

        expect(result).to eq(instance)
      end
    end

    context "without a blind index" do
      it "are not searchable" do
        expect do
          described_class.find_by(state: "PA", age: 25)
        end.to raise_error(ActiveRecord::StatementInvalid, a_string_including("column users.state does not exist"))
      end
    end
  end

  describe "relations" do
    it { is_expected.to have_many(:user_data_brokers) }
    it { is_expected.to have_many(:data_brokers).through(:user_data_brokers) }
  end
end
