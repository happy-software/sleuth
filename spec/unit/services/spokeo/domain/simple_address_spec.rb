describe Spokeo::Domain::SimpleAddress do
  it "has the right attributes" do
    instance = Spokeo::Domain::SimpleAddress.new(state: "IL", city: "Chicago", current: true)

    expect(instance).to have_attributes(
      state: "IL",
      city: "Chicago",
      current: true,
    )
  end
end
