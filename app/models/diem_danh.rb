class DiemDanh < ActiveRecord::Base
  has_paper_trail
  attr_accessible :ma_sinh_vien, :so_tiet_vang

  delegate :lop_mon_hoc, :to => :lich_trinh_giang_day, :allow_nil => false
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lich_trinh_giang_day

  validates :ma_sinh_vien, :presence => true  
  

  after_save :set_default
  
   
  
  private
  
  def set_default
   l = lop_mon_hoc.lop_mon_hoc_sinh_viens.where(ma_sinh_vien: ma_sinh_vien).first    
    if l
      l.tong_so_tiet = lop_mon_hoc.so_tiet
      l.so_vang_co_phep = lich_trinh_giang_day.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang, :conditions => {:phep => true})
      l.so_tiet_vang = lich_trinh_giang_day.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang)      
      l.save! rescue "tong vang co phep error"
    end
  
  end 
 
end
