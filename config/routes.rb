Rails.application.routes.draw do
  root :to => "sessions#create"
  get 'login' => "sessions#create" , as: 'login'
  get 'callback' => "sessions#callback" , as: 'callback'
  get 'load_user' => "sessions#load_user", :as => 'load_user'
  get 'logout' => "sessions#destroy", :as => 'logout'
 
  resources :accounts do
    resources :transactions
  end

  resources :payments do
    member do 
      get 'mtan'
      get 'deny'
      get 'approve'
      patch 'mtan_confirm'
    end
    collection do
      get 'to_approve'
      get 'for_approval'
    end
  end
 
  get '*path' => "four_o_four#index" , as: 'pagenotfound'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
