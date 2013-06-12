class SinhVien < ActiveRecord::Base
  attr_accessible :gioi_tinh, :ho_dem, :lop_hc, :ma_he_dao_tao, :ma_khoa_hoc, :ma_nganh, :ma_sinh_vien, :ngay_sinh, :ten

  validates :ma_sinh_vien, :uniqueness => { :case_sensitive => false }
  validates :lop_hc, :ma_he_dao_tao, :ma_khoa_hoc, :ma_nganh, :ten, :presence => true

  has_one :user, :as => :imageable
  delegate :username, :to => :user
  has_one :can_bo_lop, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy
  has_many :lop_mon_hocs, :through => :lop_mon_hoc_sinh_viens    
  has_many :diem_chuyen_cans, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy do 
  	def with_lop(ma_lop)
  		where("diem_chuyen_cans.ma_lop" => ma_lop)
  	end
  end
  has_many :diem_danhs, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy do 
  	def with_lop(ma_lop)
  		where("diem_danhs.ma_lop" => ma_lop)
  	end
  end
end
