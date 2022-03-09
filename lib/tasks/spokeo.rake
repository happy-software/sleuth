require "httpx"
require "pry"

# This is an example request to Spokeo, and how it can return information about a person
namespace :spokeo do
  task search: :environment do
    name = "Riley Claire"
    state = "Colorado"

    result = Spokeo::Search.run(name: name, state: state)
    # search_result = Spokeo::Search.run(name: name, state: state)
    binding.pry
  end
end
