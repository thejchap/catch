# frozen_string_literal: true

module Catch
  module GraphQL
    module Mutations
      class AvailabilityCreate < Base
        null true
        argument :day, Int, required: true
        argument :starts_at, Int, required: true
        argument :ends_at, Int, required: true
        field :availability, Types::Availability, null: true
        field :errors, [String], null: false

        def services
          {
            create: ::Catch::Availability::Create
          }
        end

        def resolve(day:, starts_at:, ends_at:)
          result = services[:create].call(
            day: day,
            range: starts_at..ends_at,
            user_id: context[:current_resource_owner].id
          )

          return { availability: result.value, errors: [] } if result.success?

          { availability: nil, errors: result.value }
        end
      end
    end
  end
end
