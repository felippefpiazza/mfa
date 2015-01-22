Rails.application.routes.draw do
 
#COMENTARIO NO ROUTES 
  #resources :people
  namespace :api do
    resource :user, :default => {:format => 'json'}
    get 'auth' => 'user#auth', :default => {:format => 'json'}
    post 'auth' => 'user#auth', :default => {:format => 'json'}      
    get 'auth_token' => 'user#auth_token', :default => {:format => 'json'}    
    post 'auth_token' => 'user#auth_token', :default => {:format => 'json'}        
    get 'generate_sms_token' => 'user#generate_sms_token', :default => {:format => 'json'}
    post 'generate_sms_token' => 'user#generate_sms_token', :default => {:format => 'json'}     
  end  
  
  namespace :admin do
    get '/' => 'user#index'
    post '/' => 'user#index'
    get '/login' => 'user#login'
    post '/login' => 'user#login'
    get '/login_token' => 'user#login_token'
    post '/login_token' => 'user#login_token'
    get '/qr' => 'user#qr'    
    

    get 'client/' => 'client#index'
    post 'client/' => 'client#index'    
    get 'client/index' => 'client#index'
    post 'client/index' => 'client#index'
    get 'client/new' => 'client#new'
    post 'client/save' => 'client#save'
    get 'client/delete' => 'client#destroy'
    get 'client/:id' => 'client#show'

    
  end
  
  #resource :user, :default => {:format => 'xml'}
  #get 'user/' => 'user#index'
  #post 'user/' => 'user#index'
  
  #map.resources :people, :has_many => :addresses
  
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
