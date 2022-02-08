# This module searches Spokeo for people.
#
# The main method for this class is the `.run` method on the class.
# The state parameter is expected to be the full state name.
#
# Spokeo uses "-" for any whitespace in parameters.
#
#
# For example:
#   - "eobard thawne" would become "Eobard-Thawne"
#   - "new jersey" would become "New-Jersey"
module Spokeo
  class Search
    Url = "https://www.spokeo.com".freeze

    def initialize(name:, state:, city: nil)
      @name = name
      @state = state
      @city = city
    end

    # Search Spokeo for a person
    #
    # This method will convert the parameters into Spokeo-compatible
    # parameters.
    #
    # Note -- the state name has to be the full state name.
    #
    # @param [String] name the name of the person
    # @param [String] state the FULL state name
    # @optional [String] city
    #
    # @return [Array[Spokeo::Domain::Person]]
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
      responses = request

      responses.each_with_object([]) do |response, results|
        search_parser = Spokeo::Parsers::Search.new(response)
        results.concat(search_parser.listings)
      end
    end

    def request
      Rails.cache.fetch(search_url, expires_in: 12.hours) do
        Rails.logger.info "No cache found! Fetching results, and caching."

        responses = Array.wrap(HTTPX.get(*search_urls))

        responses.each_with_object([]) do |response, output|
          output.push(response.body.to_s) if response.status == 200
        end
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
