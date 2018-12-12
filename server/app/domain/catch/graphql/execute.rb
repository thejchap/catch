# frozen_string_literal: true

module Catch
  module GraphQL
    class Execute < ::Service::Base
      def call(variables:, query:, operation_name:, context: {})
        variables = ensure_hash variables

        success Schema.execute(
          query,
          variables: variables,
          context: context,
          operation_name: operation_name
        )
      end

      private

      def ensure_hash(ambiguous_param)
        case ambiguous_param
        when String
          if ambiguous_param.present?
            ensure_hash(JSON.parse(ambiguous_param))
          else
            {}
          end
        when Hash, ActionController::Parameters
          ambiguous_param
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
        end
      end
    end
  end
end
