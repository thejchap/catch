module Catch
  module Availability
    module Matching
      class Graph < ::Catch::Shared::ServiceBase
        def call(location_id:)
          success Store.read(location_id)
        end
      end
    end
  end
end
