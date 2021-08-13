module Spokeo
  class Search
    Url = "https://www.spokeo.com".freeze

    def initialize(name:, state:, city: nil)
      @name = name
      @state = state
      @city = city
    end

    def self.run(name:, state:, city: nil)
      new(
        name: to_spokeo_param(name),
        state: to_spokeo_param(state),
        city: city.present? ? to_spokeo_param(city) : nil,
      ).run
    end

    def self.to_spokeo_param(str)
      str.downcase.split(" ").map(&:capitalize).join("-")
    end

    def run
      listings = find_listings

      listings.map do |listing|
        Spokeo::Domain::Person.new(
          full_name: listing.name,
          profile_url: "#{Url}#{listing.url}",
          age: listing.age,
          related_to: listing.relatives,
          addresses: listing.addresses,
        )
      end.uniq
    end

    private

    def find_listings
      responses = Rails.cache.fetch(search_url, expires_in: 12.hours) do
        Rails.logger.info "No cache found! Fetching results, and caching."

        if search_urls.size > 1
          HTTPX
            .get(*search_urls)
            .select { |response| response.status == 200 }
            .map { |response| response.body.to_s }
        else
          [HTTPX.get(search_url).body.to_s]
        end
      end

      responses.each_with_object([]) do |response, results|
        search_parser = Spokeo::Parsers::Search.new(response)
        results.concat(search_parser.listings)
      end
    end

    def search_url
      @search_url ||= "#{Url}/#{@name}/#{@state}".freeze
    end

    def search_urls
      [].tap do |urls|
        urls << "#{search_url}/#{@city}" if @city.present?
        urls << search_url
      end
    end
  end
end
