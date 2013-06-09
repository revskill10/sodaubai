class TkbGiangVien < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'

  validates :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau, :presence => true
  
end
