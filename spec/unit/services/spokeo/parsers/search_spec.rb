describe Spokeo::Parsers::Search do
  let(:mock_html) { File.read(Rails.root.join("spec", "fixtures", "spokeo_response.html")) }

  subject { described_class.new(mock_html) }

  describe "#listings" do
    it "returns an array of listings" do
      expect(subject.listings).to include(
        an_instance_of(Spokeo::Parsers::Listing).and have_attributes(
          name: "Claire Therese Riley",
          age: 73,
          relatives: ["Michelle Riley", "Kathleen Riley", "Patrick Riley", "John Riley"],
          addresses: include(
            an_instance_of(Spokeo::Domain::SimpleAddress)
            .and have_attributes(
              city: "Boulder", state: "CO", current: true
            )
          ),
          url: a_string_including("/Claire-Riley/Colorado/Boulder")
        )
      )
    end
  end
end

