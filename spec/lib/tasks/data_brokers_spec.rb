describe "data_brokers:populate" do
  include_context "rake"

  let(:task_path) { "lib/tasks/data_brokers" }

  it "creates new data brokers" do
    expect { subject.invoke }.to change { DataBroker.count }.by(5)
  end
end
