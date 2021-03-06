module Spokeo
  module Parsers
    class Search
      ListingCssClass = ".single-column-list-item".freeze

      def initialize(html_string)
        @html_string = html_string
      end

      def listing_nodes
        html_node.css(ListingCssClass)
      end

      def listings
        listing_nodes.map do |listing|
          Spokeo::Parsers::Listing.new(listing)
        end
      end

      private

      def html_node
        @html_node ||= Nokogiri::HTML(@html_string)
      end
    end
  end
end
