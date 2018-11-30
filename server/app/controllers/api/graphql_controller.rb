module API
  class GraphQLController < ::ActionController::API
    def execute
      result = Catch::GraphQL::Execute.call(
        variables:      params[:variables],
        operation_name: params[:operationName],
        query:          params[:query]
      )

      render json: result.value
    end
  end
end
