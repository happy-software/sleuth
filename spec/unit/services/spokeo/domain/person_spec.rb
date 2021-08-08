describe Spokeo::Domain::Person do
  let(:mock_address) { Spokeo::Domain::SimpleAddress.new(city: "Star City", state: "IL", current: true) }

  describe "attributes" do
    it "sets the right attrs" do
      name = "Eobard Thawne"
      url = "/Eobard-Thawne/123"
      age = 35
      related_to = ["Barry Allen"]
      addresses = [mock_address]

      instance = Spokeo::Domain::Person.new(
        full_name: name,
        profile_url: url,
        age: age,
        related_to: related_to,
        addresses: addresses,
      )

      expect(instance).to have_attributes(
        full_name: name,
        profile_url: url,
        age: age,
        related_to: related_to,
        addresses: addresses,
      )
    end
  end

  describe "methods" do
    describe "#to_s" do
      context "when the person is related to someone" do
        it "includes the people they are related to" do
          instance = Spokeo::Domain::Person.new(
            full_name: "Eobard Thawne",
            profile_url: "/Eobard-Thawne/123",
            related_to: ["Barry Allen"],
          )

          expect(instance.to_s).to match(
            a_string_including("Eobard Thawne related to Barry Allen"),
          )
        end
      end
      
      context "when the person is not related to someone" do
        it "only has their name" do
          instance = Spokeo::Domain::Person.new(
            full_name: "Eobard Thawne",
            profile_url: "/Eobard-Thawne/123",
          )
          expect(instance.to_s).not_to match(
            a_string_including("related to"),
          )
        end
      end
      
      context "when the person's age is provided" do
        it "includes their age" do
          instance = Spokeo::Domain::Person.new(
            full_name: "Eobard Thawne",
            profile_url: "/Eobard-Thawne/123",
            age: 35,
          )
          expect(instance.to_s).to match(
            a_string_including("Eobard Thawne (Age: 35)"),
          )
        end
      end

      context "when the person's age is not provided" do
        it "does not include age information" do
          instance = Spokeo::Domain::Person.new(
            full_name: "Eobard Thawne",
            profile_url: "/Eobard-Thawne/123",
          )
          expect(instance.to_s).not_to match(
            a_string_including("Age:"),
          )
        end
      end

      context "when age and related_to are specified" do
        it "includes all of them" do
          instance = Spokeo::Domain::Person.new(
            full_name: "Eobard Thawne",
            profile_url: "/Eobard-Thawne/123",
            related_to: ["Barry Allen"],
            age: 35
          )

          expect(instance.to_s).to eq("Eobard Thawne related to Barry Allen (Age: 35)")
        end
      end
    end

    describe "#lived_in?" do
      let(:mock_address_2) { Spokeo::Domain::SimpleAddress.new(city: "Gotham City", state: "NY") }

      let(:person) {
        Spokeo::Domain::Person.new(
          full_name: "Eobard Thawne",
          profile_url: "/Eobard-Thawne/123",
          addresses: [mock_address, mock_address_2],
        )
      }

      it "returns true if the user currently lives in the state, city" do
        expect(person.lived_in?(state: "IL", city: "Star City", currently: true)).to be_truthy
      end

      context "only state passed in" do
        it "is true if the user lived in that state" do
          expect(person.lived_in?(state: "IL")).to be_truthy
        end

        it "is false if the user did not live in that state" do
          expect(person.lived_in?(state: "WI")).to be_falsey
        end
      end

      context "when currently is passed in" do
        it "returns true if the user is currently living in that state" do
          expect(person.lived_in?(state: "IL", currently: true)).to be_truthy
        end

        it "returns false if the user isn't currently living in a state" do
          expect(person.lived_in?(state: "NY")).to be_truthy
          expect(person.lived_in?(state: "NY", currently: true)).to be_falsey
        end
      end

      context "when city is passed in" do
        it "returns true if the user lived in that city" do
          expect(person.lived_in?(state: "NY", city: "Gotham City")).to be_truthy
        end

        it "returns false if the user never lived in that city" do
          expect(person.lived_in?(state: "IL", city: "Central City")).to be_falsey
        end
      end
    end
  end
end
