# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class GraphResult
        attr_reader :graph, :updated_at

        def initialize(graph, updated_at = nil)
          @graph = graph
          @updated_at = updated_at
        end

        def fetch(day, object, filter_policy: nil)
          unfiltered = graph.dig(day, object.id) || []
          return unfiltered if filter_policy.blank?

          unfiltered.select { |match| filter_policy.valid?(match) }
        end
      end
    end
  end
end
