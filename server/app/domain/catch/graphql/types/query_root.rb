module Catch
  module GraphQL
    module Types
      class QueryRoot < Types::BaseObject
        field :nodes, field: ::GraphQL::Relay::Node.plural_field
        field :node,  field: ::GraphQL::Relay::Node.field
        field :me,    Types::User, null: false

        def me
          context[:current_resource_owner]
        end
      end
    end
  end
end
