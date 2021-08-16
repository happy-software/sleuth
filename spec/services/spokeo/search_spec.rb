describe Spokeo::Search do
  describe ".run" do
    it "delegates to an instance" do
      stub = instance_double(described_class)

      allow(described_class).to receive(:new).with(name: "Riley-Claire", state: "Colorado", city: nil).and_return(stub)

      allow(stub).to receive(:run)

      described_class.run(name: "Riley Claire", state: "Colorado")

      expect(stub).to have_received(:run)
    end
  end

  describe ".to_spokeo_param" do
    it "capitalizes and hyphenates multiple words together" do
      expect(described_class.to_spokeo_param("hello ceLeRy mAn")).to eq("Hello-Celery-Man")
    end
  end

  describe "Url" do
    it do
      expect(described_class::Url).to eq("https://www.spokeo.com")
    end
  end

  describe "#run" do
    subject { described_class.new(name: "Riley-Claire", state: "Colorado") }

    let(:mock_html) { File.read(Rails.root.join("spec/fixtures/spokeo_response.html")) }

    before do
      allow(Rails.cache).to receive(:fetch).and_return([mock_html])
    end

    it "returns listings" do
      expect(subject.run).to include(
        an_instance_of(Spokeo::Domain::Person).and have_attributes(
          full_name: "Claire Therese Riley",
          profile_url: a_string_including("https://www.spokeo.com/Claire-Riley/Colorado/Boulder"),
          age: 73,
          related_to: ["Michelle Riley", "Kathleen Riley", "Patrick Riley", "John Riley"],
          addresses: include(
            an_instance_of(Spokeo::Domain::SimpleAddress).and have_attributes(
              city: "Boulder",
              state: "CO",
              current: true,
            )
          ),
        )
      )
    end
  end
end
