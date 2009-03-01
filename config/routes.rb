ActionController::Routing::Routes.draw do |map|
  
  # Homepage
  map.root :controller => 'home'
  
  # Resources
  map.resources :events
  map.resources :meetings, :controller => 'events'
  map.resources :podcasts, :as => 'podcast'
  map.resources :users, :member => {:edit_profile => :get}
  map.resources :widgets
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
