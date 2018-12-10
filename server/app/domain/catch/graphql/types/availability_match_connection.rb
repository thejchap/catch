module Catch
  module GraphQL
    module Types
      class AvailabilityMatchConnection < ::GraphQL::Types::Relay::BaseConnection
        edge_type Types::AvailabilityMatchEdge

        field :any, Boolean, null: false
        field :count, Int, null: false

        def any
          object.nodes.any?
        end

        def count
          object.nodes.length
        end
      end
    end
  end
end
