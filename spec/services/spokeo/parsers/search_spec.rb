describe Spokeo::Parsers::Search do
  subject(:listings) { described_class.new(mock_html).listings }

  let(:mock_html) { File.read(Rails.root.join("spec/fixtures/spokeo_response.html")) }

  describe "#listings" do
    it "returns an array of listings" do
      expect(listings).to all(be_a(Spokeo::Parsers::Listing))
    end
  end
end
