class DiemDanh < ActiveRecord::Base  
  include DestroyedAt
  include PublicActivity::Common
  #tracked owner: Proc.new{ |controller, model| controller.current_user }
  attr_accessible :ma_sinh_vien, :so_tiet_vang, :lich_trinh_giang_day_id

  delegate :lop_mon_hoc, :to => :lich_trinh_giang_day, :allow_nil => false
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lich_trinh_giang_day

  validates :ma_sinh_vien, :presence => true  
  
  delegate :tuan, :to => :lich_trinh_giang_day, :allow_nil => false

  after_save :set_default
  
  
  def tuan
    lich_trinh_giang_day.tuan
  end
  
  private
  
  def set_default
    if lop_mon_hoc
      l = lop_mon_hoc.lop_mon_hoc_sinh_viens.where(ma_sinh_vien: ma_sinh_vien).first    
       if l
        l.tong_so_tiet = lop_mon_hoc.so_tiet
        l.so_vang_co_phep = lop_mon_hoc.lich_trinh_giang_days.inject(0){|sum,x| sum + x.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang, :conditions => {:phep => true}) }
        l.so_tiet_vang =  lop_mon_hoc.lich_trinh_giang_days.inject(0){|sum,x| sum + x.diem_danhs.where(ma_sinh_vien: ma_sinh_vien).sum(:so_tiet_vang) }
        l.save! rescue "tong vang co phep error"
      end
    end
  end 
 
end
