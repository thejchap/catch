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
          matches_graph.then do |result|
            result.value.fetch day, object, stale_before: [
              object.updated_at,
              current_user.updated_at
            ].min
          end
        end

        def services
          {
            matches: ::Catch::Availability::Matching::Graph
          }
        end

        private

        def matches_graph
          @match_graph ||= Loaders::ServiceResultLoader.for(
            services[:matches]
          ).load(location_id: current_user.settings_location)
        end
      end
    end
  end
end
