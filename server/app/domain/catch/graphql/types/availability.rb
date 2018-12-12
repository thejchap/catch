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
          matches_graph.then do |graph_result|
            val = graph_result.value
            next [] if matches_stale?(val.updated_at)
            val.graph.dig(day, model_id) || []
          end
        end

        def services
          {
            matches: ::Catch::Availability::Matching::Graph
          }
        end

        private

        def matches_stale?(time)
          object.updated_at > time
        end

        def matches_graph
          @match_graph ||= Loaders::ServiceResultLoader.for(
            services[:matches]
          ).load(location_id: current_user.settings_location)
        end
      end
    end
  end
end
