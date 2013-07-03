# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_mon_hoc, :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :phong, :so_tiet_day

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  delegate :giang_vien, :to => :lop_mon_hoc

  validates :ma_lop, :ma_mon_hoc, :ngay_day, :presence => true
  after_create :set_default

  private 
  def set_default      
    self.xac_nhan_sv = false
  end

end
