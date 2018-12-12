# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class WriterJob < ::ActiveJob::Base
        queue_as :matching

        def perform(location_id:)
          location = ::Location.fetch location_id
          services[:write].call(location: location).success?
        end

        private

        def services
          {
            write: Write
          }
        end
      end
    end
  end
end
