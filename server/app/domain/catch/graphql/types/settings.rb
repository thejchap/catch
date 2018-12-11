module Catch
  module GraphQL
    module Types
      class Settings < BaseObject
        field :activities, [Types::Activity], null: false
        field :location, String, null: true

        def activities
          object.fetch 'activities', []
        end
      end
    end
  end
end
