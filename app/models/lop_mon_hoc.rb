class LopMonHoc < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'

  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  has_many :tkb_giang_vien, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy

  validates :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :presence => true
  validates :ma_lop, :uniqueness => {:case_sensitive => false}
end
