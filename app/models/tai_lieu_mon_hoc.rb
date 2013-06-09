class TaiLieuMonHoc < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :noi_dung
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'

  validates :ma_lop, :noi_dung,  :presence => true

  before_create :set_default

  private
  def set_default
  	self.nam_hoc = self.lop_mon_hoc.nam_hoc
  	self.hoc_ky = self.lop_mon_hoc.hoc_ky
  	self.ma_giang_vien = self.lop_mon_hoc.ma_giang_vien
  	self.ma_mon_hoc = self.lop_mon_hoc.ma_mon_hoc
  end
end
