Rails.application.routes.draw do
  post '/api/graphql', to: "api/graphql#execute"
  root 'application#index'

  use_doorkeeper
end
