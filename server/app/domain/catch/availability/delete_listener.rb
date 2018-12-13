# frozen_string_literal: true

module Catch
  module Availability
    class DeleteListener
      class << self
        def deleted(availability_id)
          services[:matching].availability_deleted availability_id
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
