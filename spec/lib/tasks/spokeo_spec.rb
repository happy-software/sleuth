# rubocop:disable RSpec/DescribeClass
describe "spokeo rake tasks" do
  include_context "when a rake task is tested"

  let(:task_path) { "lib/tasks/spokeo" }

  describe "test_search_connectivity" do
    let(:task_name) { "spokeo:test_search_connectivity" }

    context "when the search is not valid" do
      before do
        allow(Spokeo::Search).to receive(:run).and_return([])
      end

      it "raises an exception" do
        expect { task.invoke }.to raise_exception(StandardError, /Expected to get results for Spokeo search/)
      end
    end

    context "when the search returns results" do
      before do
        allow(Spokeo::Search).to receive(:run).and_return([
          an_instance_of(Spokeo::Domain::Person),
          an_instance_of(Spokeo::Domain::Person),
        ])
      end

      it "is OK" do
        expect { task.invoke }.not_to raise_error
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass
