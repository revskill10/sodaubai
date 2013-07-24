class DiemChuyenCan < ActiveRecord::Base
  attr_accessible :diem, :ma_mon, :ma_lop, :ma_sinh_vien

  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  delegate :so_tiet, :to => :lop_mon_hoc
  
  

  

end
