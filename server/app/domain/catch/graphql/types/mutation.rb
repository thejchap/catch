module Catch
  module GraphQL
    module Types
      class Mutation < Types::BaseObject
        field :availability_create, mutation: Mutations::AvailabilityCreate
        field :availability_update, mutation: Mutations::AvailabilityUpdate
      end
    end
  end
end
