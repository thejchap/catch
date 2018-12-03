module Catch
  module GraphQL
    module Types
      class Availability < Model
        field :day,       Int,    null: false
        field :starts_at, Int,    null: false
        field :ends_at,   Int,    null: false
        field :user_id,   String, null: false
      end
    end
  end
end
