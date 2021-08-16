module Spokeo
  module Parsers
    class Listing
      # css finders
      TitleCssClass = ".title".freeze

      # grep-able words
      RelatedTo = "Related To".freeze
      LivedIn = "Lived In".freeze
      ResidesIn = "Resides in".freeze

      def initialize(listing)
        @listing = listing
      end

      def url
        @listing["href"]
      end

      def name
        title_node.text.split(", ")[0]
      end

      def age
        title_node.text.split(", ")[1].to_i
      end

      def relatives
        related_node = title_node.parent.children.find do |child|
          child.children.text.include?(RelatedTo)
        end

        return [] unless related_node

        related_node.children.map(&:text).join(" ").gsub!("#{RelatedTo} ", "").split(", ")
      end

      def addresses
        [].tap do |addresses|
          lives_in_addr = lives_in
          lived_at_addr = lived_at

          addresses << lives_in_addr if lives_in_addr.present?
          addresses.concat(lived_at_addr) if lived_at_addr.present?
        end
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/CyclomaticComplexity
      def lives_in
        lives_in_node = title_node.parent.children.find do |child|
          child.attribute_nodes.any? { |node| node.name == "type" }
        end

        return nil unless lives_in_node

        parsed_lived_in = lives_in_node.css("strong").text&.gsub!("#{ResidesIn} ", "")

        return nil unless parsed_lived_in

        city_state_parts = parsed_lived_in.split(", ")
        state = city_state_parts.last

        city = city_state_parts.size > 2 ? city_state_parts[0..-2].join(", ") : city_state_parts.first

        Spokeo::Domain::SimpleAddress.new(city: city, state: state, current: true)
      end

      def lived_at
        lived_at_node = title_node.parent.children.find do |child|
          child.text.include?(LivedIn)
        end

        parsed_lived_at = lived_at_node&.children&.text&.gsub!(LivedIn, "")&.split(", ") || []

        parsed_lived_at.map do |result|
          city_state_parts = result.split(" ")

          city = city_state_parts[0..-2].join(" ")
          state = city_state_parts[-1]

          Spokeo::Domain::SimpleAddress.new(city: city, state: state)
        end
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/CyclomaticComplexity

      private

      def title_node
        @title_node ||= @listing.at_css(TitleCssClass)
      end
    end
  end
end
