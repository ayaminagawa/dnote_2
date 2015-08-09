Dnote2::Application.routes.draw do

  get "/nutritionist_show" ,to: "users#nutritionist_show"
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get "/nutritionist_show" ,to: "users#nutritionist_show"
  
  get "contacts/new"
  post "contacts/create"
  
  devise_for :nutritionists, controllers: {
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }
 
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    :passwords => "users/passwords",
    :registrations => "users/registrations",
    :sessions => "users/sessions"
  }

  resources :menus
  resources :users
  resources :menu_recipes
  resources :ingredients
  resources :made_reports
  resources :recipes
  resources :favorites, only: [:create, :destroy]
  resources :nutritionists
  resources :columns


  get "menu/new"
  get "menu/create"
  get "menu/destroy"
  root  'about#index'
  match '/about', to:'about#index', via:'get'
  get "company", to: "about#company"
  get "security_information", to: "about#security_information"
  get "privacy_policy", to: "about#privacy_policy"

  get "about/index"


  get '/kinds', to:'recipes#recipe_kinds'
  get '/categories', to:'recipes#recipe_categories'
  get '/calories', to:'recipes#calories'
  get '/search', to:'recipes#search'

  get '/menu_recipes', to:'menus#menu_recipes'

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
