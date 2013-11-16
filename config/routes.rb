Trytest::Application.routes.draw do
  
  
  mount Resque::Server, :at => "/workers"
  match "/jobs" => Resque::Server, :anchor => false, :constraints => lambda { |req|
    req.env['warden'].authenticated? and req.env['warden'].user.is_admin?
  }
  ActiveAdmin.routes(self)

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :tkb_giang_viens
      resources :lop_mon_hoc_sinh_viens
      resources :sinh_viens do 
        member do 
          get 'trucnhat' => 'sinh_viens#trucnhat'
          get 'tkb' => 'sinh_viens#tkb'
        end
      end
      resources :giang_viens
      resources :lop_mon_hocs
    end
  end

  match '/rate' => 'rater#create', :as => 'rate'

  get "dashboard/index"
  match '/activity' => "dashboard#activity"
  match '/calendar' => 'dashboard#calendar', :as => "calendar"
  match '/post_calendar' => 'dashboard#post_calendar', :as => "post_calendar"
  match 'tuan/:id' => 'dashboard#show', :as => "tuan"
  get "dashboard/access_denied", :as => "access_denied"
   root :to => 'dashboard#index'
  devise_for :users do
   get '/users/sign_out' => 'devise/cas_sessions#destroy'
  end
  
  
  
  resources :users
  resources :giang_viens do 
    member do 
      get '/report' => 'giang_viens#report'
    end
  end
  resources :mon_hocs
  resources :sinh_viens
  resources :phongs
  resources :lop_mon_hocs do           
    resources :tkb_giang_viens      
    member do 
      post '/update_hoten' => 'lop_mon_hocs#update_hoten'
      post '/update_diemqt' => 'lop_mon_hocs#update_diemqt'
      post '/update_diemcc' => 'lop_mon_hocs#update_diemcc'
      get '/calendar' => 'lop_mon_hocs#calendar'        
      get '/search' => 'lop_mon_hocs#search'
      get '/report' => 'lop_mon_hocs#report'
      get '/t/:tuan_id' => 'lop_mon_hocs#tuan'
      get '/showdkbs' => 'lop_mon_hocs#showdkbs', :as => 'showdkbs'
      post '/dkbs' => 'lop_mon_hocs#dkbs', :as => 'dkbs'
      post '/qldkbs' => 'lop_mon_hocs#qldkbs', :as => 'qldkbs'
      get '/lichtrinh' => 'lop_mon_hocs#lichtrinh', :as => 'lichtrinh'
      get '/tinhhinh' => 'lop_mon_hocs#tinhhinh', :as => 'tinhhinh'
      #get '/elichtrinh' => 'lop_mon_hocs#export_lichtrinh', :as => 'elichtrinh'
      get 'phieudiem'
    end    
    resources :diem_chi_tiets      do  
      collection do        
        get '/:loai' => 'diem_chi_tiets#index'
        post '/:loai'  => 'diem_chi_tiets#create'
      end
    end
    resources :diem_chuyen_cans do 
      collection do 
        post '/update' => 'diem_chuyen_cans#update'
      end
    end    
    resources :lop_mon_hoc_sinh_viens  do 
      collection do 
        post '/groupupdate' => 'lop_mon_hoc_sinh_viens#groupupdate'
        get '/group' => 'lop_mon_hoc_sinh_viens#group'
      end
    end  
    resources :topics do 
      resources :posts
    end  
    resources :can_bo_lops
    resources :tai_lieu_mon_hocs
    resources :thong_bao_lop_hocs
    resources :dang_ky_day_bus
    resources :kien_nghis
    resources :nhat_kies
    resources :ra_som_vao_muons
    resources :day_thays
    resources :nghi_days
    resources :buoihoc do 
      member do
        post 'rate' => 'buoihoc#rate'
        post 'update', :as => 'update'          
        post 'diemdanh'
        get 'diemdanh' => 'buoihoc#get_diemdanh'
        post 'calendar'
        post 'daybu'
        post 'nghiday'
        post 'daythay'
        post 'doigio'
        get 'quanly' => 'buoihoc#get_quanly'
        get 'lichtrinh'
        get 'lichtrinh_edit' => 'buoihoc#lichtrinh_edit'
        post 'lichtrinh' => 'buoihoc#syllabus'        
      end        
    end
  end
  get "quanly" => 'quanly#index', :as => 'quanly'
  match 'quanly/lopghep' => 'quanly#lopghep', :as => 'quanlylopghep'
  match 'quanly/nghiday' => 'quanly#nghiday', :as => 'quanlynghiday'
  match 'quanly/daybu' => 'quanly#daybu', :as => 'quanlydaybu'
  match 'quanly/dkbs' => 'quanly#dkbs', :as => 'quanlydkbs'
  post 'quanly/filtersv' => 'quanly#filtersv', :as => 'filtersv'
  post 'quanly/filterlophc' => 'quanly#filterlophc', :as => 'filterlophc'
  post 'quanly/filterloptc' => 'quanly#filterloptc', :as => 'filterloptc'
  post 'quanly/checklopghep' => 'quanly#checklopghep', :as => 'checklopghep'
  post 'quanly/updatelopghep' => 'quanly#updatelopghep', :as => 'updatelopghep'
  post 'quanly/movelopghep' => 'quanly#movelopghep', :as => 'movelopghep'
  post 'quanly/qlnghiday' => 'quanly#qlnghiday', :as => 'qlnghiday'
  post 'quanly/qldaybu' => 'quanly#qldaybu', :as => 'qldaybu'
  post 'quanly/qldkbs' => 'quanly#qldkbs', :as => 'qldkbs'
  get 'quanly/phongtrong' => 'quanly#phongtrong', :as => 'phongtrong'
  post 'quanly/getphongtrong' => 'quanly#getphongtrong', :as => 'getphongtrong'
  match 'quanly/nghidayhangloat' => 'quanly#nghidayhangloat', :as => 'nghidayhangloat'
  post 'quanly/post_nghidayhangloat' => 'quanly#post_nghidayhangloat', :as => 'post_nghidayhangloat'
  post 'quanly/huynghiday' => 'quanly#huynghiday', :as => 'huynghiday'
  get "quanly/report1" => 'quanly#report1', :as => 'report1'
  get "quanly/report2/(:tuan)" => 'quanly#report2', :as => 'report2'
  get "quanly/report3" => 'quanly#report3', :as => 'report3'
  get "quanly/report4/(:tuan)" => 'quanly#report4', :as => 'report4'
  get "quanly/report5/(:tuan)" => 'quanly#report5', :as => 'report5'
  get "monitor" => 'monitor#index', :as => 'monitor'
  get "monitor/activity" => 'monitor#activity', :as => 'activity'
  get "monitor/:lop_mon_hoc_id/:id" => 'monitor#show', :as => 'showmonitor'
  get "monitor/daybu/:lop_mon_hoc_id/:id" => 'monitor#showdaybu', :as => 'showmonitordaybu'
  get "admin" => 'admin#index', :as => 'admin'
  get "trucnhat" => 'monitor#trucnhat', :as => 'trucnhat'
  get "thanhtra" => 'monitor#thanhtra', :as => 'thanhtra'
  get "quanly/vipham" => 'quanly#vipham', :as => 'vipham'
  post "quanly/qlvipham" => 'quanly#qlvipham', :as => 'qlvipham'
  get "quanly/qlvipham(/:tuan)" => 'quanly#qlvipham', :as => 'qlvipham'
  get "monitor/:lop_mon_hoc_id/:phong/:id/trucnhat" => 'monitor#showtrucnhat', :as => 'showtrucnhat'
  get "monitor/:lop_mon_hoc_id/:phong/:id/thanhtra" => 'monitor#showthanhtra', :as => 'showthanhtra'
  post "monitor/qltrucnhat" => 'monitor#qltrucnhat', :as => 'qltrucnhat'
  post "monitor/qlthanhtra" => 'monitor#qlthanhtra', :as => 'qlthanhtra'  
  get "search" => 'dashboard#search', :as => 'search'
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

