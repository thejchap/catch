module Catch
  module GraphQL
    module Mutations
      class Base < ::GraphQL::Schema::RelayClassicMutation
        def current_user
          context[:current_resource_owner]
        end

        def authorize(action, object)
          result = ::Catch::Authorization::Authorize.call(
            current_user,
            action,
            object
          )

          return true if result.success?
          return false, { errors: %i[unauthorized] }
        end
      end
    end
  end
end
