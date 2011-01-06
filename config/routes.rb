ActionController::Routing::Routes.draw do |map|
  
  # Homepage
  map.root :controller => 'home'
  map.tshirts '/tshirts',  :controller => 'home', :action => "tshirts"
  map.thanks '/thanks',  :controller => 'home', :action => "thanks"
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'new'

  # Pages
  map.sponsors '/sponsors', :controller => 'pages', :action => 'sponsors'

  # Resources
  map.resources :podcasts, :as => 'podcast'
  map.resources :projects
  map.resources :users, :member => {:edit_profile => :get}
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
