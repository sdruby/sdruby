SDRuby::Application.routes.draw do

  # Homepage
  root to: 'pages#index'
  
  # Custom routes
  match "/forgot" => "users#forgot_password", as: :password_reset
  match "/login" => "user_sessions#new", as: :login
  match "/logout" => "user_sessions#destroy", as: :logout
  match "/photos" => "photos#index"
  match "/register" => "users#new", as: :register
  match "/sponsors" => "pages#sponsors", as: :sponsors
  match "/team" => "pages#team", as: :team
  match "/thanks" => "pages#thanks", as: :thanks
  match "/tshirts" => "pages#tshirts", as: :tshirts
  match "/speak" => "pages#speak", as: :speak

  # Resources
  resources :podcasts, :path => :podcast do
    get :search, on: :collection    
  end
  
  resources :projects do
    get :featured, on: :collection
  end

  resources :users
  resource :user_session

end
