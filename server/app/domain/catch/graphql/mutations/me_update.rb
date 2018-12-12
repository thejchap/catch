# frozen_string_literal: true

module Catch
  module GraphQL
    module Mutations
      class MeUpdate < Base
        null true
        argument :settings_activities, [Types::Activity], required: false
        argument :settings_location, String, required: false
        field :me, Types::User, null: true
        field :errors, [String], null: false

        def services
          {
            update: ::Catch::User::Update
          }
        end

        def authorized?(_ctx)
          true
        end

        def resolve(attrs)
          result = services[:update].call(
            record: ::User.lock.find(current_user.id),
            attributes: attrs
          )

          return { me: result.value, errors: [] } if result.success?

          { availability: nil, errors: result.value }
        end
      end
    end
  end
end
