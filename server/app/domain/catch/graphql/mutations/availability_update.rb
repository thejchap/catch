module Catch
  module GraphQL
    module Mutations
      class AvailabilityUpdate < Base
        null true
        argument :id, ID, required: true, loads: Types::Availability, as: :record
        argument :day, Int, required: true
        argument :starts_at, Int, required: true
        argument :ends_at, Int, required: true
        field :availability, Types::Availability, null: true
        field :errors, [String], null: false

        def services
          {
            update: ::Catch::Availability::Update
          }
        end

        def authorized?(args)
          authorize :update?, args[:record]
        end

        def resolve(record:, day:, starts_at:, ends_at:)
          result = services[:update].call(
            record: ::Availability.lock.find(record.id),
            day:    day,
            range:  starts_at..ends_at,
          )

          return { availability: result.value, errors: [] } if result.success?
          { availability: nil, errors: result.value }
        end
      end
    end
  end
end
