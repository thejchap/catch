module Catch
  module GraphQL
    module Types
      class AvailabilityMatchEdge < ::GraphQL::Types::Relay::BaseEdge
        node_type Types::Availability

        field :jaccard, Float,  null: false
        field :rank, Int, null: false
        field :day, Int, null: false
        field :best_match,  Boolean, null: false
        field :activities_intersection, [Types::Activity], null: false
        field :activities_intersection_count, Int, null: false

        def best_match
          rank == 0
        end

        def activities_intersection_count
          object.node.activities_intersection_count
        end

        def activities_intersection
          object.node.activities_intersection
        end

        def node
          object.node.node
        end

        def day
          object.node.day
        end

        def jaccard
          object.node.jaccard
        end

        def rank
          object.node.rank
        end
      end
    end
  end
end
