Rails.application.routes.draw do
  # get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'static_pages/home'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # Import one book
  get 'import_one' => 'books#import_one'
  post 'import_one' => 'books#check_exist'
  get 'edit_number' => 'books#edit_number'
  patch 'edit_number' => 'books#update_number'

  # Batch import
  get 'import_mul' => 'books#import_mul'
  patch 'import_mul' => 'books#process_batch_import'

  get 'query' => 'books#search'
  post 'query' => 'books#query'

  # Borrow and return books
  get 'card_id' => 'cards#card_id'
  post 'card_id' => 'cards#show'

  # Borrow
  get 'borrow_book_id' => 'cards#show'
  patch 'borrow_book_id' => 'cards#borrow_book'

  # Return
  get 'return_book_id' => 'cards#show'
  patch 'return_book_id' => 'cards#return_book'

  # Manage cards
  get 'cards/index'
  get 'cards/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  resources :books, only: [:index, :create]
  resources :cards, only: [:index, :show, :create, :destroy]

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
