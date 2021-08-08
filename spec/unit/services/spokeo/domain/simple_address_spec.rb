describe Spokeo::Domain::SimpleAddress do
  let(:instance) { described_class.new(state: "IL", city: "Chicago", current: true) }

  it "has the right attributes" do
    expect(instance).to have_attributes(
      state: "IL",
      city: "Chicago",
      current: true,
    )
  end
end
