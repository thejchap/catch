module Catch
  module GraphQL
    module Types
      class AvailabilityMatch < Model
        field :day,       Int,    null: false
        field :starts_at, Int,    null: false
        field :ends_at,   Int,    null: false
        field :user,      Types::User, null: false

        def user
          ::User.fetch object.user_id
        end
      end
    end
  end
end
