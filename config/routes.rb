Osp::Application.routes.draw do

  resources :albums


  resources :images


  resources :media


  resources :news


  mount RedactorRails::Engine => '/redactor_rails' 

  resources :users do
             resources :messages do
               collection do
                 post :delete_selected
               end
             end
           end

resources :user_sessions, :dashboards, :static_pages
match 'login' => 'user_sessions#new', :as => :login
match 'logout' => 'user_sessions#destroy', :as => :logout
match 'logowanie' => 'user_sessions#new', :as => :login
match 'rejestracja' => 'users#new', :as => :rejestracja
match 'about' => 'static_pages_#about'
match 'kontakt' => 'static_pages_#kontakt'
match 'galeria' => 'static_pages_#galeria'
match 'resethasla' => 'static_pages#resethasla'
match 'admin_panel' => 'static_pages_#admin_panel'
match '/dashboards/add_comment' => 'dashboards#add_comment'
match '/news/add_comment' => 'news#add_comment'
match '/dashboards/destroy_comment/:id' => 'dashboards#destroy_comment', :as => 'destroy_comment'
match '/news/destroy_comment/:id' => 'news#destroy_comment', :as => 'destroy_comment'
match '/static_pages/contact' => 'static_pages#contact'
match '/static_pages/reset_pass' => 'static_pages#reset_pass'
root :to => "static_pages_#start"

match 'potwierdz/:id' => 'users#potwierdz', :as => 'potwierdz'
match 'odwolaj/:id' => 'users#odwolaj', :as => 'odwolaj'
match 'reset_avatar/:id' => 'users#reset_avatar', :as => 'reset_avatar'
match 'upload_avatar/:id' => 'users#upload_avatar', :as => 'upload_avatar'

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
