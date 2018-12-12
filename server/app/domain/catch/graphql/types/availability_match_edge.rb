# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class AvailabilityMatchEdge < ::GraphQL::Types::Relay::BaseEdge
        node_type Types::Availability

        field :rank, Int, null: false
        field :activities_intersection, [Types::Activity], null: false

        class << self
          def scope_items(items, context)
            my_activities = context[:current_resource_owner].settings_activities

            items.select do |item|
              (item[:node_activities] & my_activities).any?
            end
          end
        end

        def activities_intersection
          object.node[:activities_intersection]
        end

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
