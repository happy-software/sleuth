describe UserDataBroker, type: :model do
  let(:user) { User.new(email: "helmut.zero@gmail.com", age: 30, state: "CA") }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:data_broker) }
  end

  describe "scopes" do
    context "with spokeo" do
      it "returns matches that point to spokeo" do
        spokeo = DataBroker.create(name: DataBroker::Spokeo)

        described_class.create(user: user, data_broker: spokeo)

        expect(described_class.spokeo).to include(
          (
            an_object_having_attributes(
              data_broker_id: spokeo.id,
            )
          ),
        )
      end
    end
  end
end
