module Catch
  module GraphQL
    module Mutations
      class MeUpdate < Base
        null true
        argument :settings_activities, [Types::Activity], required: true
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

        def resolve(settings_activities:)
          result = services[:update].call(
            record: ::User.lock.find(current_user.id),
            settings_activities: settings_activities
          )

          return { me: result.value, errors: [] } if result.success?
          { availability: nil, errors: result.value }
        end
      end
    end
  end
end
