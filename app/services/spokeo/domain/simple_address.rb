module Spokeo
  module Domain
    class SimpleAddress
      attr_reader :city, :state, :current

      def initialize(state:, city: nil, current: false)
        @state = state
        @city = city
        @current = current
      end
    end
  end
end
