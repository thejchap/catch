# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class AvailabilityMatchConnection < ::GraphQL::Types::Relay::BaseConnection
        edge_type Types::AvailabilityMatchEdge

        field :any, Boolean, null: false
        field :count, Int, null: false

        def any
          nodes.any?
        end

        def count
          nodes.length
        end
      end
    end
  end
end
