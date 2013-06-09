class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'

  validates :hoc_ky, :nam_hoc, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :presence => true
end
