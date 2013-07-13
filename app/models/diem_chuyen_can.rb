class DiemChuyenCan < ActiveRecord::Base
  attr_accessible :diem, :ma_mon, :ma_lop, :ma_sinh_vien

  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  

  
  before_create :set_values

  def tong_vang
    res = 0
    dds = DiemDanh.where(ma_lop: self.ma_lop, ma_sinh_vien: self.ma_sinh_vien)
    if dds.count > 0 then
      dds.each do |dd|
        res += dd.so_tiet_vang
      end
    end
    return res
  end
  private
  def set_values  
  	self.tong_so_tiet = self.lop_mon_hoc.so_tiet
  	self.tong_so_tiet_vang ||= 0  
  	self.sinh_vien.diem_danhs.with_lop(self.ma_lop).each do |dd|
  		self.tong_so_tiet_vang += dd.so_tiet_vang
  	end
  end
end
