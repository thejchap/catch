module Catch
  module Availability
    module Matching
      class WriterJob < ::ActiveJob::Base
        queue_as :default

        def perform(location_id:)
          services[:write].call location_id: location_id
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
