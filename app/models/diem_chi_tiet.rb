class DiemChiTiet < ActiveRecord::Base
  attr_accessible :diem, :hoc_ky, :lan, :loai_diem, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'

  validates :ma_mon_hoc, :ma_lop, :ma_sinh_vien, :presence => true
  
      	  
end
