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
        lives_in = title_node.parent.children.find do |child|
          child.attribute_nodes.any? { |node| node.name == "type" }
        end

        if lives_in
          parsed_lived_in = lives_in.css("strong").text&.gsub!("#{ResidesIn} ", "")

          if parsed_lived_in
            city_state_parts = parsed_lived_in.split(", ")
            state = city_state_parts.last

            city = city_state_parts.size > 2 ? city_state_parts[0..-2].join(", ") : city_state_parts.first

            lives_in = Spokeo::Domain::SimpleAddress.new(city: city, state: state, current: true)
          end
        end

        lived_at = title_node.parent.children.find do |child|
          child.text.include?(LivedIn)
        end

        if lived_at
          parsed_lived_at = lived_at.children&.text&.gsub!(LivedIn, "")&.split(", ")

          if parsed_lived_at.present?
            lived_at = parsed_lived_at.map do |result|
              city_state_parts = result.split(" ")

              city = city_state_parts[0..-2].join(" ")
              state = city_state_parts[-1]

              Spokeo::Domain::SimpleAddress.new(city: city, state: state)
            end
          end
        end

        [].tap do |addresses|
          addresses << lives_in if lives_in.present?
          addresses += lived_at if lived_at.present?
        end
      end

      private

      def title_node
        @title_node ||= @listing.at_css(TitleCssClass)
      end
    end
  end
end
