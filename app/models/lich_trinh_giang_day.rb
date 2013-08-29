# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  

  # Danh sach lich dang ky nghi day


  scope :nghiday, -> {where(loai: 1)}
  scope :nghidaychoduyet, -> {nghiday.where(status: 6)}
  scope :nghidaykoduyet, -> {nghiday.where(status: 4)}
  scope :nghidaydaduyet, -> {nghiday.where(status: 3)}
  scope :daybu, -> {where(loai: 2)}
  scope :daybuchoduyet, -> {daybu.where(status: 6)}
  scope :daybukoduyet, -> {daybu.where(status: 4)}
  scope :daybudaduyet, -> {daybu.where(status: 3)}
  scope :choduyet, -> {where(status: 6)}


  #delegate :ma_lop, :to => :lop_mon_hoc
  #delegate :ma_mon_hoc, :to => :lop_mon_hoc
  
  attr_accessible :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :so_tiet_day, :so_vang, :ngay_day_moi, :ma_giang_vien_moi, :ma_mon_hoc_moi, :ten_mon_hoc_moi, :loai, :status, :tuan_moi, :so_tiet_day_moi, :lop_mon_hoc_moi_id

  belongs_to :lop_bo_sung, :class_name => "LopMonHoc", :foreign_key => :lop_mon_hoc_moi_id
  belongs_to :lop_mon_hoc
  belongs_to :giang_vien_moi, :class_name => "GiangVien", :foreign_key => :ma_giang_vien_moi, :primary_key => :ma_giang_vien
  has_many :diem_danhs do 
    def vang
      where("so_tiet_vang > 0")      
    end    
  end
  TIET = {1 => [6,30], 2 => [7,20], 3 => [8,10],
    4 => [9,5], 5 => [9,55], 6 => [10, 45],
    7 => [12,30], 8 => [13,20], 9 => [14,10],
    10 => [15, 5], 11 => [15, 55], 12 => [16, 45],
    13 => [18, 0], 14 => [18, 50], 15 => [19,40], 16 => [20,30]}
  def self.compare(g1, g2)
    return 1 if g1[0] > g2[0]
    return -1 if g1[0] < g2[0]
    if g1[0] == g2[0]
      return 1 if g1[1] > g2[1]
      return 0 if g1[1] == g2[1]
      return -1 if g1[1] < g2[1]
    end
  end
  def self.xac_dinh_gio(dt)
    x = [dt.hour, dt.minute]
    ts = TIET.reject {|k,v| compare(v,x) == 1}
    t = ts.values.last  
    h = DateTime.new(dt.year, dt.month, dt.day, t[0], t[1])
    return h
  end
  def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def doigio?
  	loai == 4 and status == 3
  end
  def nghiday?
  	loai == 1 and status == 3
  end
  def daybu?
  	loai == 2 and status == 3
  end
  def daythay?
  	loai == 3 and status == 3
  end  
  def gvpending?
  	status == 1
  end
  def gvaccept?
    status == 2
  end
  def qlpending?
  	status == 3
  end
  def qlaccept?
    status == 4
  end
  validates :ngay_day, :presence => true
  
  def score
  	return "#{rating_score} / #{ratings}" if ratings and ratings > 0
  	return "" unless  ratings or ratings == 0  		  	
  end
  def info
    if loai == 1
      if status == 6 
        "Nghỉ dạy chờ xét duyệt"
      elsif status == 3
        "Nghỉ dạy đã được chấp nhận"
      elsif status == 4
        "Nghỉ dạy không được duyệt"
      end
    elsif loai == 2
      if status == 6 
        "Dạy bù chờ xét duyệt"
      elsif status == 3
        "Dạy bù đã được chấp nhận: Ngày dạy bù: #{ngay_day_moi.localtime}, phòng: #{phong_moi}"
      elsif status == 4
        "Dạy bù không được duyệt"
      end
    elsif loai == 3
      if status == 6 
        "Dạy thay chờ xét duyệt"
      elsif status == 3
        "Dạy thay đã được chấp nhận"
      elsif status == 4
        "Dạy thay không được duyệt"
      end
    elsif loai == 4
      if status == 6 
        "Đổi giờ chờ xét duyệt"
      elsif status == 3
        "Đổi giờ đã được chấp nhận"
      elsif status == 4
        "Đổi giờ không được duyệt"
      end
    else
      ""
    end
  end
end
