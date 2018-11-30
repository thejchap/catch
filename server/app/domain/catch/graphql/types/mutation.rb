module Catch
  module GraphQL
    module Types
      class Mutation < Types::BaseObject
        field :availability_create, mutation: Mutations::AvailabilityCreate
      end
    end
  end
end
