# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class Write < ::Catch::Shared::ServiceBase
        def call(location:)
          graph = build location
          result = Store.write location, graph
          success result
        end

        private

        def build(location)
          services[:build].call(location: location).value
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
