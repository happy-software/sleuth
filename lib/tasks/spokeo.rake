require "httpx"
require "pry"

# This is an example request to Spokeo, and how it can return information about a person
namespace :spokeo do
  task search: :environment do
    # name = "Riley Claire"
    # state = "Colorado"

    # result = Spokeo::Search.run(name: name, state: state)
    # search_result = Spokeo::Search.run(name: name, state: state)
    # binding.pry
  end

  task test_search_connectivity: :environment do |rake_task|
    name = "Riley Claire"
    state = "Colorado"

    result = Spokeo::Search.run(name: name, state: state)

    raise "Expected to get results for Spokeo search, but did not" if result.size == 0

    Rails.logger.tagged(rake_task.name) do
      Rails.logger.info { "OK" }
    end
  end
end
