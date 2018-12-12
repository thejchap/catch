# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class Graph < ::Catch::Shared::ServiceBase
        def call(location:)
          success Store.read(location)
        end
      end
    end
  end
end
