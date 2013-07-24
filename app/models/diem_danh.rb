class DiemDanh < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc, :ngay_vang, :so_tiet_vang, :loai, :diem_thuong_xuyen

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :presence => true  
  
  after_save :set_default
  
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
  def set_default
    tong_vang_co_phep
    tong_vang
  end

  def tong_vang_co_phep  
    dcc = DiemChuyenCan.where(ma_mon_hoc: ma_mon_hoc, ma_lop: ma_lop, ma_sinh_vien: ma_sinh_vien).first_or_create!
    dds = DiemDanh.where(ma_mon_hoc: ma_mon_hoc, ma_lop: ma_lop, ma_sinh_vien: ma_sinh_vien)
    if dds.count > 0 then
      dcc.tong_vang_co_phep = 0
      dds.each do |dd|        
        dcc.tong_vang_co_phep = dcc.tong_vang_co_phep + dd.so_tiet_vang if dd.phep == true and dd.so_tiet_vang > 0
      end
    end
    dcc.save! rescue "tong vang co phep error"
  end
  
  def tong_vang
    dcc = DiemChuyenCan.where(ma_mon_hoc: ma_mon_hoc, ma_lop: ma_lop, ma_sinh_vien: ma_sinh_vien).first_or_create!
    dds = DiemDanh.where(ma_mon_hoc: ma_mon_hoc, ma_lop: ma_lop, ma_sinh_vien: ma_sinh_vien)
    if dds.count > 0 then
      dcc.tong_so_tiet_vang = 0
      dds.each do |dd|        
        dcc.tong_so_tiet_vang = dcc.tong_so_tiet_vang + dd.so_tiet_vang
      end
    end
    dcc.save! rescue "tong vang error"
  end
end
