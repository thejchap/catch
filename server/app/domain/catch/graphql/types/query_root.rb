module Catch
  module GraphQL
    module Types
      class QueryRoot < Types::BaseObject
        field :nodes, field: ::GraphQL::Relay::Node.plural_field
        field :node,  field: ::GraphQL::Relay::Node.field
      end
    end
  end
end
