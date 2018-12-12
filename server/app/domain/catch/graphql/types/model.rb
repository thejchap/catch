# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class Model < BaseObject
        global_id_field :id
        field :model_id, String, null: false
        field :model_class, String, null: false
        implements ::GraphQL::Relay::Node.interface

        class << self
          def authorized?(object, context)
            current_user = context[:current_resource_owner]
            services[:authorize].call(current_user, :show?, object).value
          end

          def services
            {
              authorize: ::Catch::Authorization::Authorize
            }
          end
        end

        def model_id
          object.id
        end

        def model_class
          object.class.name
        end
      end
    end
  end
end
