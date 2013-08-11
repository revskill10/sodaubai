class DiemDanh < ActiveRecord::Base
  attr_accessible :ma_sinh_vien, :nam_hoc, :ngay_vang, :so_tiet_vang, :loai, :diem_thuong_xuyen

  belongs_to :lop_mon_hoc
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_sinh_vien, :ngay_vang, :presence => true  
  
  after_save :set_default
  
  
  scope :thongtin, lambda {|ma_lop, ma_mon_hoc,ma_sinh_vien, ngay_vang| 
    where(:ma_lop=>ma_lop).where(:ma_mon_hoc => ma_mon_hoc)
    .where(:ma_sinh_vien=>ma_sinh_vien).where(:ngay_vang => Time.zone.parse(ngay_vang.to_s))
  }
  
  scope :sotietvang, lambda{|ma_lop, ma_mon_hoc, ma_sinh_vien|
    where(:ma_lop => ma_lop).where(:ma_mon_hoc => ma_mon_hoc).where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang)
  }
  
  private
  
  def set_default
    tong_vang_co_phep
    
    
  end
  def self.convert_dcc(diem)
    case diem
    when 100
      4
    when 90..99
      3
    when 80..89
      2
    when 70..79
      1
    else
      0
    end
  end
  def tong_vang_co_phep  
    l = lop_mon_hoc.lop_mon_hoc_sinh_viens.where(ma_sinh_vien: ma_sinh_vien).first    
    if l
      l.so_vang_co_phep = lop_mon_hoc.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang, :conditions => {:phep => true})
      l.so_tiet_vang = lop_mon_hoc.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang)      
      l.save! rescue "tong vang co phep error"
    end
  end
 
end
