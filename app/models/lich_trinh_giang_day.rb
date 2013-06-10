# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  attr_accessible :ma_lop, :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :phong, :so_tiet_day

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  delegate :giang_vien, :to => :lop_mon_hoc

  validates :ma_lop, :presence => true
  after_save :set_default

  private 
  def set_default
    self.nam_hoc = self.lop_mon_hoc.nam_hoc
    self.hoc_ky = self.lop_mon_hoc.hoc_ky
    self.ma_mon_hoc = self.lop_mon_hoc.ma_mon_hoc
    self.xac_nhan_sv = false
  end

end
