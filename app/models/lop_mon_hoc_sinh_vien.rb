class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_sinh_vien
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_lop, :ma_sinh_vien, :presence => true  

  after_create :set_default
  protected
  def set_default
  	self.nam_hoc = self.lop_mon_hoc.nam_hoc
  	self.hoc_ky = self.lop_mon_hoc.hoc_ky
  	self.ma_mon_hoc = self.lop_mon_hoc.ma_mon_hoc
  end
end
