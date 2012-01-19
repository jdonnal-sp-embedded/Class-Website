Website::Application.routes.draw do

  root :to => "home#index"
  match 'info' =>"info#index"
  match 'info/objectives' =>"info#objectives"
  match 'useful_stuff/r31jp'=>"useful_stuff#r31jp"
  match 'useful_stuff/burnit' =>"useful_stuff#burnit"
  match 'useful_stuff/amulet' =>"useful_stuff#amulet"
  match 'useful_stuff/multimedio' => "useful_stuff#multimedio"
  match 'useful_stuff/datasheets' => "useful_stuff#datasheets"
  match 'useful_stuff/misc' => "useful_stuff#misc"
  match 'useful_stuff/latex' => "useful_stuff#latex"
  match 'useful_stuff/problems' => "useful_stuff#problems"
  match 'useful_stuff/ideas' => "useful_stuff#ideas"
  match 'useful_stuff/parts' => "useful_stuff#parts"
  
  match 'admin' => 'admin#index'
  match 'admin/new_user(.:format)'=>'users#new'
  devise_for :users
  namespace :admin do
    resources :users
    resources :events do
      resources :slots, :only=>[:create,:destroy, :update]
    end
  end
  resources :events, :only=>[:show]
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
  # match ':controller(/:action(/:id(.:format)))'
end
