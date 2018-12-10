module Catch
  module GraphQL
    module Types
      class QueryRoot < Types::BaseObject
        field :nodes,           field: ::GraphQL::Relay::Node.plural_field
        field :node,            field: ::GraphQL::Relay::Node.field
        field :me,              Types::User, null: false
        field :availabilities,  [Types::Availability], null: false, extras: %i[irep_node]

        def availabilities(irep_node:)
          services[:my_availabilities].call(user: me).value
        end

        def me
          current_user
        end

        def services
          {
            my_availabilities: ::Catch::Availability::MyAvailabilities
          }
        end
      end
    end
  end
end
