Edubay::Application.routes.draw do

  get "/seminars/bachelorpro" => "seminars#bachelorpro"
  get "/seminars/bachelor" => "seminars#bachelor"
  get "/seminars/master" => "seminars#master"
  
  get "/practicals/bachelor" => "practicals#bachelor"
  get "/practicals/master" => "practicals#master"
  
  resources :courses, only: [:index]
  
  # Für die Veranstaltungen existieren zwei Controller, ein normaler und einer für den Admin
  # resources :courses, only: [ :index, :show ] do
    # resources :documents do
      # member do
        # get 'download'
      # end
    # end
  # end
# 
  # namespace :admin do
    # resources :courses do
      # resources :documents do
        # member do
          # get 'download'
        # end
      # end
    # end
  # end
  
  # Startseite, Tutorial, etc.
  get "home/index"
  get "home/intro"

  # Omniauth URLs
  get "/auth/:provider/callback" => "session#create"
  get "/signout" => "session#destroy", as: :signout

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
  root to: 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
