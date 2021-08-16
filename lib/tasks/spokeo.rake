require "httpx"
require "pry"

namespace :spokeo do
  task search: :environment do |_|
    name = "Riley Claire"
    state = "Colorado"

    Spokeo::Search.run(name: name, state: state)
    # search_result = Spokeo::Search.run(name: name, state: state)
    # binding.pry
  end
end
