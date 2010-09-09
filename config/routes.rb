ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resource :users

  map.resource :session

  map.admin 'admin', :controller => 'admin/admin'
  map.namespace :admin do |admin|
    admin.resources :users,
                    :collection => { :delete_parent => :delete, :delete_child => :delete, :delete_classroom => :delete, :delete_group => :delete },
                    :member => { :update_family_ties => :put, :update_classroom => :put, :update_group => :put }
    admin.resources :classrooms,
                    :collection => { :delete_user => :delete, :graduates => :get, :future => :get },
                    :member => { :students => :get, :schedule => :get }
    admin.resources :groups,
                    :collection => { :delete_user => :delete }
    admin.resource :preference,
                    :member => { :create_subject_name => :post, :destroy_subject_name => :delete }
    admin.resources :subjects,
                    :member => { :create_lecture => :post, :timetable => :get },
                    :collection => { :delete_lecture => :delete }
    admin.resources :semesters, :collection => { :edit_change_semester => :get, :update_change_semester => :put } do |semester|
      semester.resources :classrooms,
                         :collection => { :delete_user => :delete, :graduates => :get, :future => :get },
                         :member => { :students => :get, :schedule => :get }
      semester.resources :groups,
                         :collection => { :delete_user => :delete }
      semester.resources :subjects,
                         :member => { :create_lecture => :post, :timetable => :get },
                         :collection => { :delete_lecture => :delete }
    end
  end

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
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
