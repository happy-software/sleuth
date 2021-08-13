describe Spokeo::Domain::Person do
  let(:mock_address) { Spokeo::Domain::SimpleAddress.new(city: "Star City", state: "IL", current: true) }

  describe "attributes" do
    let(:instance) do
      described_class.new(
        full_name: "Eobard Thawne",
        profile_url: "/Eobard-Thawne/123",
        age: 35,
        related_to: ["Barry Allen"],
        addresses: [mock_address],
      )
    end

    it "sets the right attrs" do
      expect(instance).to have_attributes(
        full_name: "Eobard Thawne",
        profile_url: "/Eobard-Thawne/123",
        age: 35,
        related_to: ["Barry Allen"],
        addresses: [mock_address],
      )
    end
  end

  describe "#to_s" do
    context "when the person is related to someone" do
      let(:instance) do
        described_class.new(
          full_name: "Eobard Thawne",
          profile_url: "/Eobard-Thawne/123",
          related_to: ["Barry Allen"],
        )
      end

      it "includes the people they are related to" do
        expect(instance.to_s).to match(a_string_including("Eobard Thawne related to Barry Allen"))
      end
    end

    context "when the person is not related to someone" do
      let(:instance) { described_class.new(full_name: "Eobard Thawne", profile_url: "/Eobard-Thawne/123") }

      it "only has their name" do
        expect(instance.to_s).not_to match(a_string_including("related to"))
      end
    end

    context "when the person's age is provided" do
      let(:instance) do
        described_class.new(
          full_name: "Eobard Thawne",
          profile_url: "/Eobard-Thawne/123",
          age: 35,
        )
      end

      it "includes their age" do
        expect(instance.to_s).to match(a_string_including("Eobard Thawne (Age: 35)"))
      end
    end

    context "when the person's age is not provided" do
      let(:instance) { described_class.new(full_name: "Eobard Thawne", profile_url: "/Eobard-Thawne/123") }

      it "does not include age information" do
        expect(instance.to_s).not_to match(a_string_including("Age:"))
      end
    end

    context "when age and related_to are specified" do
      let(:instance) do
        described_class.new(
          full_name: "Eobard Thawne",
          profile_url: "/Eobard-Thawne/123",
          related_to: ["Barry Allen"],
          age: 35,
        )
      end

      it "includes all of them" do
        expect(instance.to_s).to eq("Eobard Thawne related to Barry Allen (Age: 35)")
      end
    end
  end

  describe "#lived_in?" do
    let(:mock_address_two) { Spokeo::Domain::SimpleAddress.new(city: "Gotham City", state: "NY") }

    let(:person) do
      described_class.new(
        full_name: "Eobard Thawne",
        profile_url: "/Eobard-Thawne/123",
        addresses: [mock_address, mock_address_two],
      )
    end

    it "returns true if the user currently lives in the state, city" do
      expect(person).to be_lived_in(state: "IL", city: "Star City", currently: true)
    end

    context "when only state passed in" do
      it "is true if the user lived in that state" do
        expect(person).to be_lived_in(state: "IL")
      end

      it "is false if the user did not live in that state" do
        expect(person).not_to be_lived_in(state: "WI")
      end
    end

    context "when currently is passed in" do
      it "returns true if the user is currently living in that state" do
        expect(person).to be_lived_in(state: "IL", currently: true)
      end

      it "returns false if the user isn't currently living in a state" do
        expect(person).not_to be_lived_in(state: "NY", currently: true)
      end
    end

    context "when city is passed in" do
      it "returns true if the user lived in that city" do
        expect(person).to be_lived_in(state: "NY", city: "Gotham City")
      end

      it "returns false if the user never lived in that city" do
        expect(person).not_to be_lived_in(state: "IL", city: "Central City")
      end
    end
  end
end
