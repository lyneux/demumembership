Demumembership::Application.routes.draw do
  
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  get '/members/by_days_to_expiry/:number_of_days_until_expiry', to: 'members#upcoming_renewals', as: 'members_by_days_to_expiry'
  get '/members/expire', to: 'members#expire', as: 'members_expire'

  get 'gocardless/confirm'

  match '/signin',                   to: 'sessions#new',                via: 'get'
  match '/signout',                  to: 'sessions#destroy',            via: 'delete'

  get '/payments/create_dd_payments', to: 'payments#create_dd_payments', as: 'payments_create_dd_payments'
  post '/payments/handle_notification',  to: 'payments#handle_notification', as: 'payments_handle_notification'

  get '/payments/test_handle_notification',  to: 'payments#test_handle_notification', as: 'payments_test_handle_notification'

  resources :members do
    resources :entitlement_periods
    resources :go_cardless_payment_methods, only: [:new]
    get 'go_cardless_payment_methods/create'
  end
  resources :area_groups
  resources :sessions, only: [:new, :create, :destroy]

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
