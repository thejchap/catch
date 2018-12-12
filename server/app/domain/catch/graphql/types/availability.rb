# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class Availability < Model
        field :day,       Int,    null: false
        field :starts_at, Int,    null: false
        field :ends_at,   Int,    null: false
        field :user,      Types::User, null: false
        field :matches,   Types::AvailabilityMatchConnection, null: false

        def user
          Loaders::IdentityCacheLoader.for(::User).load object.user_id
        end

        def matches
          return [] if current_user.settings_location.blank?

          graph.then { |result| resolve_graph result.value }
        end

        def services
          {
            graph: ::Catch::Availability::Matching::Graph,
            filter_policy: ::Catch::Availability::Matching::MatchFilterPolicy
          }
        end

        private

        def resolve_graph(graph)
          filter_policy = services[:filter_policy].new object, current_user, graph
          graph.fetch day, object, filter_policy: filter_policy
        end

        def graph
          Loaders::IdentityCacheLoader.for(::Location).load(current_user.settings_location).then do |location|
            Loaders::ServiceResultLoader.for(services[:graph]).load(location: location)
          end
        end
      end
    end
  end
end
