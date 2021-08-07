require "httpx"
require "pry"

namespace :spokeo do
  task search: :environment do |_|
    state = "florida"
    name = "my name"

    search_result = Spokeo::Search.run(name: name, state: state)

    binding.pry
  end
end
