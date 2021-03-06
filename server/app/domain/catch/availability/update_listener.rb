# frozen_string_literal: true

module Catch
  module Availability
    class UpdateListener
      class << self
        def updated(availability_id)
          services[:matching].availability_updated availability_id
        end

        private

        def services
          {
            matching: ::Catch::Availability::Matching::Listener
          }
        end
      end
    end
  end
end
