class ThongBaoLopHoc < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_giang_vien, :nam_hoc, :noi_dung, :thoi_gian

  
  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'
  validates :noi_dung, :presence => true
  belongs_to :lop_mon_hoc
  
  
end
