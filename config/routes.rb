Rails.application.routes.draw do
  root  " urls#index"

  resources :urls,
    only: [:index, :create, :update, :destroy, :show]
  get "/urls/:id/:user_token" , to: "urls#show"
  get "/urls" , to: "urls#index"
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure" , to: redirect("/")
  get "/users" , to: "users#index",
    as: "dashboard"
  get "signout" , to: "sessions#destroy",
    as: "signout"

  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      get "requests/show/:target(/:short_url(/:user_token))" , to: "requests#show"
    end
  end
  get "/:path" , to: "reroute#index"
end
