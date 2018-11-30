module Catch
  module GraphQL
    module Types
      class Availability < Model
        field :day, Types::Weekday, null: false
      end
    end
  end
end
