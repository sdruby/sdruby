ActionController::Routing::Routes.draw do |map|
  
  # Homepage
  map.root :controller => 'home'
  map.tshirts '/tshirts',  :controller => 'home', :action => "tshirts"
  map.thanks '/thanks',  :controller => 'home', :action => "thanks"

  # Resources
  map.resources :events
  map.resources :meetings, :controller => 'events'
  map.resources :podcasts, :as => 'podcast'
  map.resources :users, :member => {:edit_profile => :get}
  map.resources :widgets
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"

  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
