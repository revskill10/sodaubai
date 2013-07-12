class DiemDanh < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc, :ngay_vang, :so_tiet_vang, :loai, :diem_thuong_xuyen

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :presence => true  
  

  
  after_initialize :default_values
  scope :thongtin, lambda {|ma_lop, ma_mon_hoc,ma_sinh_vien, ngay_vang| 
    where(:ma_lop=>ma_lop).where(:ma_mon_hoc => ma_mon_hoc)
    .where(:ma_sinh_vien=>ma_sinh_vien).where(:ngay_vang => Time.zone.parse(ngay_vang.to_s))
  }
  
  scope :sotietvang, lambda{|ma_lop, ma_mon_hoc, ma_sinh_vien|
    where(:ma_lop => ma_lop).where(:ma_mon_hoc => ma_mon_hoc).where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang)
  }
  
  private
  def default_values
  	self.so_tiet_vang ||= 0
    self.diem_thuong_xuyen ||= 0
  end  
  
end
