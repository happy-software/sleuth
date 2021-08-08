module Spokeo
  module Domain
    class Person
      attr_reader :full_name, :profile_url, :age, :related_to, :addresses

      def initialize(full_name:, profile_url:, age: nil, related_to: [], addresses: [])
        @full_name = full_name
        @profile_url = profile_url
        @age = age
        @related_to = related_to
        @addresses = addresses
      end

      def to_s
        name = full_name.dup
        name = "#{name} related to #{related_to.join(", ")}" if related_to.any?
        name = "#{name} (Age: #{age})" unless age.nil?
        name
      end

      def lived_in?(state:, city: nil, currently: false)
        addresses.any? do |addr|
          next false if city.present? && addr.city != city
          next false if currently && !addr.current

          addr.state == state
        end
      end
    end
  end
end
