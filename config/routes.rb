Rails.application.routes.draw do
  root  'urls#new'

  resources :urls, only: [:new, :create, :update, :destroy, :show]
  get '/urls', to: "urls#new"
  get "auth/:provider/callback", to: "sessions#create"
  get 'auth/failure', to: redirect("/")
  get '/users', to: "users#index", as: "dashboard"
  get 'signout', to: "sessions#destroy", as: "signout"

  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      get 'requests/show/:target(/:short_url(/:user_token))', to: "requests#show"
      # get 'requests/update/:target/:short_url/:user_token/:data', to: "requests#update"
      # get 'requests/destroy/:short_url/:user_token', to: "requests#destroy"
      # get 'requests/create/:original/:user_token(/:short_url)', to: "requests#create"
    end
  end
  get '/:path', to: "reroute#index"

end
