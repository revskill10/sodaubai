class SinhVien < ActiveRecord::Base

  
  FACETS = [:lop_hc]
  searchable  :auto_index => false, :auto_remove => false do 
    text :ten, :boost => 5
    text :ho, :ho_dem, :lop_hc, :ma_he_dao_tao, :ma_khoa_hoc, :ma_nganh, :ma_sinh_vien, :ten_nganh
    text :hovaten do 
      (ho || "") + " " + (ho_dem || "") + (ten || "")
    end
    time :ngay_sinh
    string :ns do 
      ngay_sinh.strftime("%B %Y")
    end
    string :lop_hc
    string :nam_hoc do 
      "2013-2014"
    end
    integer :hoc_ky do 
      1
    end
  end

  default_scope order('ten, ho_dem, ngay_sinh, gioi_tinh')
  attr_accessible :gioi_tinh, :ho_dem, :lop_hc, :ma_he_dao_tao, :ma_khoa_hoc, :ma_nganh, :ma_sinh_vien, :ngay_sinh, :ten, :trang_thai, :ten_nganh, :ngay

  validates :ma_sinh_vien, :uniqueness => { :case_sensitive => false }
  validates :ma_sinh_vien, :presence => true

  has_one :user, :as => :imageable  
  has_one :can_bo_lop, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy
      
  has_many :diem_chuyen_cans, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy do 
  	def with_lop(ma_lop)
  		where("diem_chuyen_cans.ma_lop" => ma_lop)
  	end
  end
  has_many :diem_danhs, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :dependent => :destroy do 
  	def with_lop(ma_lop)
  		where("diem_danhs.ma_lop" => ma_lop)
  	end        
  end
  
  def thong_tin_diem_danh(ma_lop, ngay_vang)
    res  = DiemDanh.by_lop_sinhvien_ngay(ma_lop, self.ma_sinh_vien, ngay_vang)
    if res.empty? then return  0 
    else return res.first.so_tiet_vang end
  end
  
  def dem
    return (ho || "") + " " + (ho_dem || "")
  end
  def fullname
    if self.ho_dem
      self.ho_dem + " " + self.ten 
    else
      self.ten
    end
  end 
  def to_s
    fullname + ": " + ma_sinh_vien
  end
  def lop_mon_hocs
   lop_mon_hoc_sinh_viens.map {|t| t and t.lop_mon_hoc }   
  end
  def lich_trinh_giang_days
    res = []
    lop_mon_hocs.each do |l|
      res = res + l.lich_trinh_giang_days
    end    
    return res
  end
  def check_conflict(lop)    
    tkbs = lop.tkb_giang_viens if lop
    tkb1 = get_tkbs
    return nil if tkbs.empty?
    tkbs.each do |tkb|
      tkb1.each do |t|
        return t if tkb.check_conflict?(t) 
      end
    end
    return nil
  end
  def get_tkbs    
    tkbs = []
    if lop_mon_hocs
      lop_mon_hocs.each do |l|
        tkbs = tkbs + l.tkb_giang_viens if l 
      end
    end
    return tkbs
  end
  def get_days
    ngays = []
    tkbs = get_tkbs
    return nil if tkbs.empty?
    get_tkbs.each do |tkb|
      ngay = JSON.parse(tkb.days)["ngay"]
      ngays = ngays + ngay
    end
    ngays = ngays.sort_by {|h| [h["tuan"], h["time"]]}
    return {:ngay => ngays}
  end
end
