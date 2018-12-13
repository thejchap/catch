Rails.application.routes.draw do
  namespace :api do
    post '/graphql', to: 'graphql#execute'
  end

  scope :api do
    use_doorkeeper
  end

  get '/me', to: 'application#index'
  get '/me/*path', to: 'application#index'
  get '/welcome/*path', to: 'application#index'
  root 'application#index'
end
