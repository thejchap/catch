module Catch
  module GraphQL
    module Types
      class AvailabilityMatchEdge < ::GraphQL::Types::Relay::BaseEdge
        node_type Types::AvailabilityMatch

        field :jaccard,   Float,  null: false
        field :distance,  Int,    null: false
        field :rank,      Int,    null: false

        def jaccard
          0.5
        end

        def distance
          1
        end

        def rank
          0
        end
      end
    end
  end
end
