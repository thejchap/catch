module Catch
  module GraphQL
    module Types
      class BaseObject < ::GraphQL::Schema::Object
        def current_user
          context[:current_resource_owner]
        end
      end
    end
  end
end
