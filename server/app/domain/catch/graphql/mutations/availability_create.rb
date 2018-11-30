module Catch
  module GraphQL
    module Mutations
      class AvailabilityCreate < Base
        null true
        argument :day, Types::Weekday, required: true
        field :availability, Types::Availability, null: true
        field :errors, [String], null: false

        def services
          {
            create: ::Catch::Availability::Create
          }
        end

        def resolve(day:)
          range = nil # TODO
          result = services[:create].call(day: day, range: range)
          return { availability: result.value, errors: [] } if result.success?
          { availability: nil, errors: result.value }
        end
      end
    end
  end
end
