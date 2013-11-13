# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  
  include DestroyedAt
  # Danh sach lich dang ky nghi day
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  scope :nghiday, -> {where(loai: 1)}
  scope :nghidaychoduyet, -> {nghiday.where(status: 6)}
  scope :nghidaykoduyet, -> {nghiday.where(status: 4)}
  scope :nghidaydaduyet, -> {nghiday.where(status: 3)}
  scope :nghidayquakhu, -> {nghiday.where("status != 6")}
  scope :daybu, -> {where(loai: 2)}
  scope :daybuchoduyet, -> {daybu.where(status: 6)}
  scope :daybukoduyet, -> {daybu.where(status: 4)}
  scope :daybudaduyet, -> {daybu.where(status: 3)}
  scope :daybuquakhu, -> {daybu.where("status != 6")}

  scope :dkbs, -> {where(loai: 5)}
  scope :dkbschoduyet, -> {dkbs.where(status: 6)}
  scope :dkbsquakhu, -> {dkbs.where("status != 6")}
  scope :choduyet, -> {where(status: 6)}

  scope :between, lambda {|time1, time2| {:conditions => ["ngay_day = timestamp ? or ngay_day = timestamp ? ", time1.utc, time2.utc]}}  
  #delegate :ma_lop, :to => :lop_mon_hoc
  #delegate :ma_mon_hoc, :to => :lop_mon_hoc
  
  attr_accessible :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :so_tiet_day, :so_vang, :ngay_day_moi, :ma_giang_vien_moi, :ma_mon_hoc_moi, :ten_mon_hoc_moi, :loai, :status, :tuan_moi, :so_tiet_day_moi, :lop_mon_hoc_moi_id, :user_id, :phong_moi, :tuan, :siso, :note

  belongs_to :lop_bo_sung, :class_name => "LopMonHoc", :foreign_key => :lop_mon_hoc_moi_id
  belongs_to :lop_mon_hoc
  belongs_to :giang_vien_moi, :class_name => "GiangVien", :foreign_key => :ma_giang_vien_moi, :primary_key => :ma_giang_vien
  has_many :diem_danhs, :dependent => :destroy do 
    def vang
      where("so_tiet_vang > 0")      
    end    
  end
  belongs_to :nguoi_duyet, :class_name => "User", :foreign_key => :user_id, :primary_key => :id
  belongs_to :nguoi_tao, :class_name => "User", :foreign_key => :creator_id, :primary_key => :id
  after_create :update_siso_and_tuan

  TIET = {1 => [6,30], 2 => [7,20], 3 => [8,10],
    4 => [9,5], 5 => [9,55], 6 => [10, 45],
    7 => [12,30], 8 => [13,20], 9 => [14,10],
    10 => [15, 5], 11 => [15, 55], 12 => [16, 45],
    13 => [18, 0], 14 => [18, 50], 15 => [19,40], 16 => [20,30]}
  CA = {1 => [6,30], 2 => [9,5], 3 => [12,30], 4 => [15,5], 5 => [18,0], 6 => [20,30]}
  def get_tuan          
    if loai == 2
      Tuan.all.detect {|t| t.tu_ngay.localtime <= ngay_day_moi.localtime and t.den_ngay.localtime >= ngay_day_moi.localtime }.stt
    else
      Tuan.all.detect {|t| t.tu_ngay.localtime <= ngay_day.localtime and t.den_ngay.localtime >= ngay_day.localtime }.stt
    end
  end
  def wday
    if loai == 2 and status == 3
      if ngay_day_moi.localtime.wday == 0 then
        8
      else
        ngay_day_moi.localtime.wday + 1 
      end
    else
      if ngay_day.localtime.wday == 0 then
        8
      else
        ngay_day.localtime.wday + 1 
      end
    end
  end
  def get_svvang
    diem_danhs.vang
  end
  def daduyet?
    loai == 1 and status == 3
  end
  def self.ca(dt)
    x = [dt.hour, dt.minute]
    ts = CA.reject {|k,v| compare(v,x) == 1}
    t = ts.values.last  
    k = ts.keys.last
    return k

  end
  def self.current
    dt = DateTime.now
    x = [dt.hour, dt.minute]
    ts = CA.reject {|k,v| compare(v,x) == 1}
    t = ts.values.last  
    k = ts.keys.last
    v = CA[k + 1]
    h = DateTime.new(dt.year, dt.month, dt.day, t[0], t[1])
    h2 = DateTime.new(dt.year, dt.month, dt.day, v[0], v[1])
    return self.between(h, h2)
  end    
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
  def self.current_tuan(ngay)
    Tuan.all.detect {|t| t.tu_ngay.localtime <= ngay and t.den_ngay.localtime >= ngay }
  end
  def self.phong_trong(ngay)
    @week = current_tuan(ngay)
    @days = JSON.parse(@week.days)["ngay"]
    @today = @days.select {|d| to_zdate(d["time"][0]).to_date == ngay }.select {|t| t["phong"] != nil}.sort_by {|a| [a["phong"], a["ca"]]}
    res = {}
    phongs = LopMonHoc::PHONGS2
    phongs.each do |phong|
      res[phong] = []
    end
    @today.each_with_index do |lich, index|
      res[lich['phong']] ||= []
      temp = {}
      temp[:ca] = LichTrinhGiangDay.ca(to_zdatetime(lich['time'][0]))
      
      temp[:ma_giang_vien] = lich['ma_giang_vien']
      temp[:ten_giang_vien] = lich['ten_giang_vien']
      temp[:ten_mon_hoc] = lich['ten_mon_hoc']
      temp[:ma_lop] = lich['ma_lop']
      temp[:lop_id] = lich['lop']
      temp[:so_tiet] = lich['so_tiet']
      res[lich['phong']] << temp
    end
    return res
  end
  def self.lich_day_phan_bo(ngay)
    @week = current_tuan(ngay)
    @days = JSON.parse(@week.days)["ngay"]
    @today = @days.select {|d| to_zdate(d["time"][0]).to_date == ngay }.select {|t| t["phong"] != nil}.sort_by {|a| [a["phong"], a["ca"]]}    
    return @today
  end
  def self.to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
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
  def self.to_zdatetime(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def svvangs
    vangs = diem_danhs.where('so_tiet_vang > 0')
    return "" if vangs.count == 0
    res = ""
    vangs.each do |v|
      res = res + v.sinh_vien.ho + " " + v.sinh_vien.fullname + ", "
    end
    res[-2] = "."
    return res
  end  
  def hienthingay
    res = ngay_day.localtime.strftime("%Hh:%M %d/%m/%Y")
    if loai == 2
      res = res + " (dạy bù vào " + ngay_day_moi.localtime.strftime("%Hh:%M %d/%m/%Y") + ")"
    end
    res
  end
  protected

  def update_siso_and_tuan
    self.siso = lop_mon_hoc.lop_mon_hoc_sinh_viens.count
    self.tuan = self.get_tuan
    self.save!
  end
end
