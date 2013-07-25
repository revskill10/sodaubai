class ThongBaoLopHoc < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :noi_dung, :thoi_gian

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  validates :ma_lop, :ma_mon_hoc, :ma_giang_vien, :noi_dung, :presence => true

  
  
end
