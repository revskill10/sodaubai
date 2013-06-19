Trytest::Application.routes.draw do
  

  

  mount Ckeditor::Engine => '/ckeditor'

  get "dashboard/index"
  get "dashboard/danhsach"
  match 'dashboard/:id' => 'dashboard#show', :as => "showdashboard"
  get "dashboard/access_denied", :as => "access_denied"
   root :to => 'dashboard#index'
  devise_for :users do
   get '/users/sign_out' => 'devise/cas_sessions#destroy'
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :tkb_giang_viens

  resources :giang_viens
  resources :mon_hocs

  resources :lop_mon_hocs, :only => :show do 
    resources :sinh_viens, :only => :index
    resources :diem_danhs
    resources :diem_chi_tiets
    resources :lich_trinh_giang_days
    resources :diem_chuyen_cans
    resources :lop_mon_hoc_sinh_viens
    resources :can_bo_lops
    resources :tai_lieu_mon_hocs
    resources :thong_bao_lop_hocs
    resources :dang_ky_day_bus
    resources :kien_nghis
    resources :nhat_kies
    resources :ra_som_vao_muons
    resources :day_thays
    resources :nghi_days
    resources :buoihoc, :only => :show do 
      member do
        post 'diemdanh'
      end
    end
  end

  match '*a', :to => 'application#routing'

  


  


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
