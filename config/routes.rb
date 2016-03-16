Rails.application.routes.draw do

  root 'landing#index'

  # New user registration
  post 'users' => 'sessions#sign_up'

  # User sessions
  post 'sessions' => 'sessions#sign_in'
  delete 'session' => 'sessions#sign_out'

  namespace :app do
    # Dashboard
    get 'dashboard' => 'dashboard#index'

    # Calendar
    get 'user_calendar' => 'user_calendar#index'

    # Projects
    resources :projects, except: [:show] do
      patch '/tasks/:id/update_task_status' => 'tasks#update_task_status', as: 'update_task_status'
      get '/tasks/:id/get_task_details' => 'tasks#get_task_details', as: 'get_task_details'
      resources :tasks
      resources :statuses, only: [:index]
    end

    # User profile
    get '/users/:id/edit(.:format)' => 'users#edit', as: 'edit_user'
    patch '/users/:id(.:format)' => 'users#update_user', as: 'update_user'
    patch '/users/:id/update_pass(.:format)' => 'users#update_password', as: 'update_user_password'
    delete '/users/:id(.:format)' => 'users#destroy', as: 'destroy_user'
  end

  # *patch match anything which was not found in routes list and redirects to root
  #get "*path" => redirect("/")


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
