Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home, only: [:index]
  root to: "home#index"

  post "/graphql", to: "graphql#create"

  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if defined?(GraphiQL::Rails::Engine)
end
