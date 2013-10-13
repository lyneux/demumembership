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

  #get 'gocardless/step1'
  #post 'gocardless/step1_submit'
  get 'gocardless/step2/:member_id', to: 'gocardless#step2', as: 'gocardless_step2'
  post 'gocardless/step2_submit'
  get 'gocardless/confirm'

  match '/gocardless/step1',         to: 'gocardless#step1',            via: 'get'
  match '/gocardless/step1_submit',  to: 'gocardless#step1_submit',     via: 'post'
  match '/signin',                   to: 'sessions#new',                via: 'get'
  match '/signout',                  to: 'sessions#destroy',            via: 'delete'

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
