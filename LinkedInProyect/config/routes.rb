Rails.application.routes.draw do

  root 'static_pages#home'

  get 'home'    => 'indices#index'
  get 'about'   => 'static_pages#about'
  get 'crew'    => 'static_pages#crew'
  get 'contact'    => 'static_pages#help'

  get '/user/:id/modify_skills/:skill_id', to: 'users#modify_skills', as:'modify_skills'
  get '/user/:id/skills', to: 'users#skills', as:'my_skills'

  resources :companies
  resources :skills
  resources :users
  resources :indices
  resources :similarities
  resources :about

  post '/indices/index'
  get '/similarities/:company/:id', to: 'similarities#output', as:'get_match'

  get 'confirm_search'    => 'indices#confirm_search'
  get '/accept_crawl/:company/:country/:id', to: 'indices#accept_crawl', as:'accept_crawl'
  get '/thankyoumail/:company/:country/:id', to: 'similarities#thankYouQueueOutput', as: 'renderthankyouqueuematch'
  get '/provideemail/:company/:country/:id', to: 'similarities#provideemail', as: 'provideemail'

  get '/createsim/:company/:country/:id', to: 'similarities#create', as: 'createsim'



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
