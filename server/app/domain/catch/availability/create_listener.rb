# frozen_string_literal: true

module Catch
  module Availability
    class CreateListener
      class << self
        def created(availability_id)
          services[:matching].availability_created availability_id
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
