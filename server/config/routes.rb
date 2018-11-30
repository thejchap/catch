Rails.application.routes.draw do
  post '/api/graphql', to: "api/graphql#execute"

  use_doorkeeper
end
