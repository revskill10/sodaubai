# RailsAdmin config file. Generated on June 11, 2013 06:45
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Trytest', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Article', 'CanBoLop', 'DangKyDayBu', 'DayThay', 'DiemChiTiet', 'DiemChuyenCan', 'DiemDanh', 'GiangVien', 'KienNghi', 'LichTrinhGiangDay', 'LopMonHoc', 'LopMonHocSinhVien', 'MonHoc', 'NghiDay', 'NhatKy', 'RaSomVaoMuon', 'SinhVien', 'TaiLieuMonHoc', 'ThongBaoLopHoc', 'TkbGiangVien', 'User']

  # Include specific models (exclude the others):
  # config.included_models = ['Article', 'CanBoLop', 'DangKyDayBu', 'DayThay', 'DiemChiTiet', 'DiemChuyenCan', 'DiemDanh', 'GiangVien', 'KienNghi', 'LichTrinhGiangDay', 'LopMonHoc', 'LopMonHocSinhVien', 'MonHoc', 'NghiDay', 'NhatKy', 'RaSomVaoMuon', 'SinhVien', 'TaiLieuMonHoc', 'ThongBaoLopHoc', 'TkbGiangVien', 'User']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  Article  ###

  # config.model 'Article' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your article.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  CanBoLop  ###

  # config.model 'CanBoLop' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your can_bo_lop.rb model definition

  #   # Found associations:

  #     configure :sinh_vien, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string         # Hidden 
  #     configure :ma_lop, :string 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DangKyDayBu  ###

  # config.model 'DangKyDayBu' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your dang_ky_day_bu.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string 
  #     configure :ma_lop, :string 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_day_dang_ky, :datetime 
  #     configure :tiet_bat_dau, :integer 
  #     configure :phong, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DayThay  ###

  # config.model 'DayThay' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your day_thay.rb model definition

  #   # Found associations:

  #     configure :giang_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_day, :datetime 
  #     configure :phong, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DiemChiTiet  ###

  # config.model 'DiemChiTiet' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your diem_chi_tiet.rb model definition

  #   # Found associations:

  #     configure :sinh_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :diem, :integer 
  #     configure :loai_diem, :string 
  #     configure :lan, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DiemChuyenCan  ###

  # config.model 'DiemChuyenCan' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your diem_chuyen_can.rb model definition

  #   # Found associations:

  #     configure :sinh_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :tong_so_tiet, :integer 
  #     configure :tong_so_tiet_vang, :integer 
  #     configure :diem, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  DiemDanh  ###

  # config.model 'DiemDanh' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your diem_danh.rb model definition

  #   # Found associations:

  #     configure :sinh_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_vang, :datetime 
  #     configure :so_tiet_vang, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  GiangVien  ###

  # config.model 'GiangVien' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your giang_vien.rb model definition

  #   # Found associations:

  #     configure :lop_mon_hocs, :has_many_association 
  #     configure :tkb_giang_viens, :has_many_association 
  #     configure :lich_trinh_giang_days, :has_many_association 
  #     configure :nghi_days, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ho_ten, :string 
  #     configure :hoc_vi, :string 
  #     configure :hoc_ham, :string 
  #     configure :ma_don_vi, :string 
  #     configure :ma_loai, :string 
  #     configure :ma_giang_vien, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  KienNghi  ###

  # config.model 'KienNghi' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your kien_nghi.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string 
  #     configure :ma_lop, :string 
  #     configure :ma_mon_hoc, :string 
  #     configure :noi_dung, :text 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :nhom_id, :integer 
  #     configure :trang_thai, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  LichTrinhGiangDay  ###

  # config.model 'LichTrinhGiangDay' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your lich_trinh_giang_day.rb model definition

  #   # Found associations:

  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_day, :datetime 
  #     configure :noi_dung_day, :text 
  #     configure :so_tiet_day, :integer 
  #     configure :nhan_xet_buoi_hoc, :text 
  #     configure :phong, :string 
  #     configure :xac_nhan_sv, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  LopMonHoc  ###

  # config.model 'LopMonHoc' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your lop_mon_hoc.rb model definition

  #   # Found associations:

  #     configure :giang_vien, :belongs_to_association 
  #     configure :mon_hoc, :belongs_to_association 
  #     configure :tkb_giang_vien, :has_many_association 
  #     configure :thong_bao_lop_hocs, :has_many_association 
  #     configure :lich_trinh_giang_days, :has_many_association 
  #     configure :diem_danhs, :has_many_association 
  #     configure :diem_chuyen_cans, :has_many_association 
  #     configure :lop_mon_hoc_sinh_viens, :has_many_association 
  #     configure :sinh_viens, :has_many_association 
  #     configure :nghi_days, :has_many_association 
  #     configure :day_thays, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_lop, :string 
  #     configure :ma_giang_vien, :string         # Hidden 
  #     configure :ma_mon_hoc, :string         # Hidden 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :so_tiet, :integer 
  #     configure :so_tuan_hoc, :integer 
  #     configure :ngay_bat_dau, :datetime 
  #     configure :ngay_ket_thuc, :datetime 
  #     configure :phong_hoc, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  LopMonHocSinhVien  ###

  # config.model 'LopMonHocSinhVien' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your lop_mon_hoc_sinh_vien.rb model definition

  #   # Found associations:

  #     configure :sinh_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  MonHoc  ###

  # config.model 'MonHoc' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your mon_hoc.rb model definition

  #   # Found associations:

  #     configure :lop_mon_hocs, :has_many_association 
  #     configure :tkb_giang_viens, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_mon_hoc, :string 
  #     configure :ten_mon, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  NghiDay  ###

  # config.model 'NghiDay' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your nghi_day.rb model definition

  #   # Found associations:

  #     configure :giang_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_day, :datetime 
  #     configure :phong, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  NhatKy  ###

  # config.model 'NhatKy' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your nhat_ky.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_nguoi_dung, :string 
  #     configure :ma_lop, :string 
  #     configure :noi_dung, :text 
  #     configure :thoi_gian, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  RaSomVaoMuon  ###

  # config.model 'RaSomVaoMuon' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your ra_som_vao_muon.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string 
  #     configure :ma_lop, :string 
  #     configure :ma_mon_hoc, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :ngay_day, :datetime 
  #     configure :loai, :integer 
  #     configure :phong, :string 
  #     configure :tiet, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  SinhVien  ###

  # config.model 'SinhVien' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your sinh_vien.rb model definition

  #   # Found associations:

  #     configure :can_bo_lop, :has_one_association 
  #     configure :lop_mon_hoc_sinh_viens, :has_many_association 
  #     configure :lop_mon_hocs, :has_many_association 
  #     configure :diem_chuyen_cans, :has_many_association 
  #     configure :diem_danhs, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_sinh_vien, :string 
  #     configure :ho_dem, :string 
  #     configure :ten, :string 
  #     configure :ngay_sinh, :date 
  #     configure :gioi_tinh, :boolean 
  #     configure :lop_hc, :string 
  #     configure :ma_khoa_hoc, :string 
  #     configure :ma_he_dao_tao, :string 
  #     configure :ma_nganh, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  TaiLieuMonHoc  ###

  # config.model 'TaiLieuMonHoc' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your tai_lieu_mon_hoc.rb model definition

  #   # Found associations:

  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :noi_dung, :text 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ThongBaoLopHoc  ###

  # config.model 'ThongBaoLopHoc' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your thong_bao_lop_hoc.rb model definition

  #   # Found associations:

  #     configure :lop_mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string 
  #     configure :noi_dung, :text 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :thoi_gian, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  TkbGiangVien  ###

  # config.model 'TkbGiangVien' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your tkb_giang_vien.rb model definition

  #   # Found associations:

  #     configure :giang_vien, :belongs_to_association 
  #     configure :lop_mon_hoc, :belongs_to_association 
  #     configure :mon_hoc, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :ma_giang_vien, :string         # Hidden 
  #     configure :ma_lop, :string         # Hidden 
  #     configure :ma_mon_hoc, :string         # Hidden 
  #     configure :phong, :string 
  #     configure :nam_hoc, :string 
  #     configure :hoc_ky, :integer 
  #     configure :tuan_hoc_bat_dau, :integer 
  #     configure :so_tuan, :integer 
  #     configure :ngay_bat_dau, :datetime 
  #     configure :ngay_ket_thuc, :datetime 
  #     configure :so_tiet, :integer 
  #     configure :tiet_bat_dau, :integer 
  #     configure :thu, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  User  ###

  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :username, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :role, :string 
  #     configure :code, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
