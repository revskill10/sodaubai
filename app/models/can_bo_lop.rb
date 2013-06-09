class CanBoLop < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc

  # association
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'


  # validations
  validates :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc, :presence => true
end
