describe Spokeo::Parsers::Listing do
  let(:mock_html) { File.read(Rails.root.join("spec", "fixtures", "spokeo_response.html")) }

  let(:listing) do
    Spokeo::Parsers::Search.new(mock_html).listing_nodes.first
  end

  subject { described_class.new(listing) }

  describe "attributes" do
    it do
      is_expected.to have_attributes(
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
    end
  end
end
