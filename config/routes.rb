SDRuby::Application.routes.draw do

  # Homepage
  root to: 'pages#index'

  # Custom routes
  get "/forgot" => "users#forgot_password", as: :password_reset
  post "/forgot" => "users#forgot_password"
  get "/login" => "user_sessions#new", as: :login
  get "/logout" => "user_sessions#destroy", as: :logout
  get "/photos" => "photos#index"
  get "/register" => "users#new", as: :register
  get "/sponsors" => "pages#sponsors", as: :sponsors
  get "/team" => "pages#team", as: :team
  get "/thanks" => "pages#thanks", as: :thanks
  get "/tshirts" => "pages#tshirts", as: :tshirts
  get "/speak" => "pages#speak", as: :speak
  get "/tutorial" => "pages#tutorial", as: :tutorial

  # Resources
  resources :podcasts, :path => :podcast do
    get :search, on: :collection
  end

  resources :projects do
    get :featured, on: :collection
  end

  resources :users do
    get :search, on: :collection
  end
  resource :user_session

end
