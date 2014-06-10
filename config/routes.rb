Ultrakast::Application.routes.draw do
  resources :events


  resources :tutors do
    collection do
      get :import
      post :upload
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "devise/omniauth_callbacks", :registrations => "devise/registrations" }

  resources :users do
    collection do
      get 'live_search'
    end
  end

  resources :posts, only: [:show, :create, :destroy] do
    resources :comments, only: [:create, :destroy], :controller => "post_actions", :type => "Comment"
  end
  
  resources :friendships, only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy], :controller => "post_actions", :type => "Like"
  resources :favorites,   only: [:create, :destroy], :controller => "post_actions", :type => "Favorite"
  resources :alerts,      only: [:destroy]
  
  match '/static_pages/switchfeed', to: 'static_pages#switch_feed', :as => 'switchfeed'
  match '/users/static_pages/switchfeed', to: 'static_pages#switch_feed', :as => 'switchfeed'
  match '/friendships/process', to: 'friendships#process_friendship', :as => 'process_friendship'
  match '/alerts/delete_all', to: 'alerts#delete_all'
  match '/about',             to: 'static_pages#about'
  
  match '/static_pages/facebook', to: 'static_pages#share_to_facebook', :as => 'facebook'
  
  root to: 'static_pages#home'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
