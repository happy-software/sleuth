# rubocop:disable RSpec/DescribeClass
describe "data_brokers:populate" do
  include_context "when a rake task is tested"

  let(:task_path) { "lib/tasks/data_brokers" }

  it "creates new data brokers" do
    expect { task.invoke }.to change(DataBroker, :count).by(5)
  end
end
# rubocop:enable RSpec/DescribeClass
