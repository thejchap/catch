module Catch
  module Availability
    module Matching
      class Write < ::Catch::Shared::ServiceBase
        def call(location_id:)
          graph = build location_id
          result = Store.write location_id, graph
          success result
        end

        private

        def build(location_id)
          services[:build].call(location_id: location_id).value
        end

        def services
          {
            build: Build
          }
        end
      end
    end
  end
end
