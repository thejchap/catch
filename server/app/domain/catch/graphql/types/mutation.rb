# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class Mutation < Types::BaseObject
        field :availability_create, mutation: Mutations::AvailabilityCreate
        field :availability_update, mutation: Mutations::AvailabilityUpdate
        field :me_update,           mutation: Mutations::MeUpdate
      end
    end
  end
end
