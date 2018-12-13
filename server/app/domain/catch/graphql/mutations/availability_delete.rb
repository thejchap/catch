# frozen_string_literal: true

module Catch
  module GraphQL
    module Mutations
      class AvailabilityDelete < Base
        null true
        argument :id, ID, required: true, loads: Types::Availability, as: :record
        field :success, Boolean, null: false
        field :errors, [String], null: false

        def services
          {
            delete: ::Catch::Availability::Delete
          }
        end

        def authorized?(args)
          authorize :delete?, args[:record]
        end

        def resolve(record:)
          result = services[:delete].call(record: ::Availability.find(record.id))
          return { success: true, errors: [] } if result.success?
          { success: false, errors: result.value }
        end
      end
    end
  end
end
