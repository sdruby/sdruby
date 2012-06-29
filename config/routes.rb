SDRuby::Application.routes.draw do

  # Homepage
  root to: 'pages#index'
  
  # Custom routes
  match "/tshirts" => "pages#tshirts", as: :tshirts
  match "/thanks" => "pages#thanks", as: :thanks
  match "/logout" => "user_sessions#destroy", as: :logout
  match "/login" => "user_sessions#new", as: :login
  match "/register" => "users#new", as: :register
  match "/sponsors" => "pages#sponsors", as: :sponsors
  match "/forgot" => "users#forgot_password", as: :password_reset
  match "/photos" => "photos#index"


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
