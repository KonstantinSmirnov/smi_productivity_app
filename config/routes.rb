Rails.application.routes.draw do

  root 'landing#index'

  # New user registration
  post 'users' => 'sessions#sign_up'

  # User sessions
  post 'sessions' => 'sessions#sign_in'
  delete 'session' => 'sessions#sign_out'

  resources :workspaces do
    resources :colleagues, :controller => "workspaces/colleagues"
    get 'dashboard' => 'workspaces/dashboard#index'
    get 'calendar' => 'workspaces/calendar#index'
    patch 'add_user' => 'workspaces/colleagues#add_user', as: 'add_user'
    delete 'remove_user/:id' => 'workspaces/colleagues#remove_user', as: 'remove_user'
  end


  # Projects
  resources :projects, except: [:show] do
    patch 'archive' => 'projects#archive', as: 'archive'
    patch '/tasks/:id/update_task_status' => 'projects/tasks#update_task_status', as: 'update_task_status'
    get '/tasks/:id/get_task_details' => 'projects/tasks#get_task_details', as: 'get_task_details'
    patch '/tasks/:id/update_description' => 'projects/tasks#update_description', as: 'update_task_description'
    get 'comments/:id/cancel_edit' => 'projects/comments#cancel_edit', as: 'cancel_comment_edit'
    get '/tasks/:id/edit_due_date' => 'projects/tasks#edit_due_date', as: 'edit_task_due_date'
    patch '/tasks/:id/update_due_date' => 'projects/tasks#update_due_date', as: 'update_task_due_date'
    resources :tasks, :controller => "projects/tasks" do
      resources :comments, :controller => "projects/comments"
    end
    resources :statuses, except: [:new], :controller => "projects/statuses"
    get 'statuses/:id/cancel_edit' => 'projects/statuses#cancel_edit', as: 'cancel_status_edit'
  end

  # User profile
  get '/users/:id/edit(.:format)' => 'users#edit', as: 'edit_user'
  patch '/users/:id(.:format)' => 'users#update_user', as: 'update_user'
  patch '/users/:id/update_pass(.:format)' => 'users#update_password', as: 'update_user_password'
  delete '/users/:id(.:format)' => 'users#destroy', as: 'destroy_user'

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
