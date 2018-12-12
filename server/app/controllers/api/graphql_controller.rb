# frozen_string_literal: true

module API
  class GraphQLController < BaseController
    def execute
      result = Catch::GraphQL::Execute.call(
        variables: params[:variables],
        operation_name: params[:operationName],
        query: params[:query],
        context: { current_resource_owner: current_resource_owner }
      )

      render json: result.value
    end

    def doorkeeper_unauthorized_render_options(*)
      { json: { errors: ['unauthorized'] } }
    end
  end
end
