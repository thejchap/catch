# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class AvailabilityMatchEdge < ::GraphQL::Types::Relay::BaseEdge
        node_type Types::Availability

        field :rank, Int, null: false

        def node
          id = object.node.dig :node, :id
          Loaders::IdentityCacheLoader.for(::Availability).load id
        end

        def rank
          object.node[:rank]
        end
      end
    end
  end
end
