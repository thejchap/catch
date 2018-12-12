module Catch
  module Availability
    module Matching
      class GraphResult
        attr_reader :graph, :updated_at

        def initialize(graph, updated_at)
          @graph = graph
          @updated_at = updated_at
        end

        def stale?(time)
          time > updated_at
        end
      end
    end
  end
end
