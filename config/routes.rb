SDRuby::Application.routes.draw do
  match "/tshirts" => "home#tshirts", as: :tshirts
  match "/thanks" => "home#thanks", as: :thanks
  match "/logout" => "user_sessions#destroy", as: :logout
  match "/login" => "user_sessions#new", as: :login
  match "/register" => "users#new", as: :register

  match "/sponsors" => "pages#sponsors", as: :sponsors

  resources :podcasts do
    get :search, on: :collection    
  end
  
  resources :projects do
    get :featured, on: :collection
  end

  resources :users
  resource :user_session

  root to: 'home#index'
end
