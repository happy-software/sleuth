describe Spokeo::Parsers::Search do
  let(:mock_html) { File.read(Rails.root.join("spec", "fixtures", "spokeo_response.html")) }

  subject { described_class.new(mock_html) }

  describe "#listings" do
    it "returns an array of listings" do
      expect(subject.listings).to all(be_a(Spokeo::Parsers::Listing))
    end
  end
end

