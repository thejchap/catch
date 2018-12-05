Rails.application.routes.draw do
  post '/api/graphql', to: "api/graphql#execute"
  use_doorkeeper

  get '/me', to: 'application#index'
  get '/me/*path', to: 'application#index'
  root 'application#index'
end
