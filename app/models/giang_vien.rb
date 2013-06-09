class GiangVien < ActiveRecord::Base
  attr_accessible :ho_ten, :hoc_ham, :hoc_vi, :ma_don_vi, :ma_giang_vien, :ma_loai
  #association
  has_many :lop_mon_hocs, :foreign_key => 'ma_giang_vien', :dependent => :destroy, :primary_key => 'ma_giang_vien'
  has_many :tkb_giang_viens, :foreign_key => 'ma_giang_vien', :dependent => :destroy, :primary_key => 'ma_giang_vien'
  #validation
  validates :ho_ten, :ma_giang_vien, :presence => true
  validates :ma_giang_vien, :uniqueness => { :case_sensitive => false }
end
