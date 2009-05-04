ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'home'
  map.home '/', :controller => 'home'
  
  map.resources :users
  map.resources :contact_infos, :controller => 'contact', :as => 'contact'
  map.resources :objectives
  map.resources :certifications
  map.resources :skills
  map.resources :experiences
  map.resources :accomplishments
  map.resources :home_messages, :controller => 'home'
	map.resource :resume, :controller => 'resume'
	
  map.categorized_project '/category/:category_name/project/:project_name', :controller => 'portfolio', :action => 'show'  
  map.connect '/category/:name', :name => /\D+/, :controller => 'categories', :action => 'show'
  map.resources :categories
  
  map.connect '/project/:name', :name => /\D+/, :controller => 'portfolio', :action => 'show'
  map.resources :projects, :controller => 'portfolio'
  map.portfolio '/portfolio', :controller => 'portfolio'
  #map.resume '/resume', :controller => 'resume'
  
  map.resource :session
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
