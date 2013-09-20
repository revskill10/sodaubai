class LopMonHoc < ActiveRecord::Base  
  include DestroyedAt
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :ten_giang_vien, :ten_mon_hoc, :dssv, :group, :user_id, :so_lan_kt, :thuc_hanh, :so_tiet_phan_bo


  # Associations
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics


  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'

  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  has_many :tkb_giang_viens, :dependent => :destroy do 
    def with_tuan(tuan)
      where("tkb_giang_viens.tuan_hoc_bat_dau = ?",tuan)
    end
  end
  has_many :lich_day_bo_sungs, :class_name => "LichTrinhGiangDay", :foreign_key => :lop_mon_hoc_moi_id
  belongs_to :user
  

  has_many :thong_bao_lop_hocs, :dependent => :destroy

  has_many :lich_trinh_giang_days, :dependent => :destroy
  has_many :diem_danhs, :through => :lich_trinh_giang_days
  
  has_many :lop_mon_hoc_sinh_viens , :dependent => :nullify
  
  has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  

  validates :ma_giang_vien, :ma_lop, :ma_mon_hoc, :presence => true
  validates_uniqueness_of :ma_lop, :scope => [:ma_giang_vien, :ma_mon_hoc]
  
  PHONGS = {:A => [["A101","A102","A103"],["A201","A202","A204","A205"],["A301","A302","A303","A305","A306"],["A401","A402","A403","A404","A405"],["A501","A502"]],
    :B => [["B101","B102","B103","B105"],["B201","B202","B203","B205"],["B301","B302","B303","B305"],["B401","B402","B403"]],
    :C => [["C101","C102","C103","C104"],["C201","C202","C203","C204"],["C301","C302","C303","C304"]],
    :D => [["D101","D102","D103"],["D201","D202","D203"],["D301","D302","D304"]],
    :E => [["E301"]],
    :F => [["F101B","F102"],["F201","F205"],["F302"]]}
  PHONGS2 = ["A101","A102","A103","A201","A202","A204","A205","A301","A302","A303","A305","A306","A401","A402","A403","A404","A405","A501","A502","B101","B102","B103","B105","B201","B202","B203","B205","B301","B302","B303","B305","B401","B402","B403","C101","C102","C103","C104","C201","C202","C203","C204","C301","C302","C303","C304","D101","D102","D103","D201","D202","D203","D301","D302","D304","E301","F101B","F102","F201","F205","F302"]
  FACETS = [:ten_mon_hoc, :ten_giang_vien, :phong_hoc]
  searchable do 
    text :ma_lop, :ma_mon_hoc, :ten_giang_vien, :ma_giang_vien, :phong_hoc, :ten_mon_hoc, :phong_hoc
    string :ten_mon_hoc
    string :ten_giang_vien
    string :phong_hoc
    string :bat_dau do 
      ngay_bat_dau.localtime.strftime("%d/%m/%Y")
    end
    string :ket_thuc do 
      ngay_ket_thuc.localtime.strftime("%d/%m/%Y")
    end
    string :nam_hoc do 
      '2013-2014'
    end
    integer :hoc_ky do 
      1
    end
  end
  after_save :update_trogiang
  def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def to_s
    "#{ma_lop} #{ten_mon_hoc} #{ten_giang_vien}"
  end
  def convert_trucnhat
    result = []
    if trucnhat 
      truc = JSON.parse(trucnhat)
      truc.each do |k,v|
        d = to_zdate(k)        
        ca = LichTrinhGiangDay.ca(d)
        if v and v.count > 0 then           
          svs = SinhVien.where(ma_sinh_vien: v)
          if svs and svs.count > 0 then 
            svs.each do |sv|
              temp = {}
              temp[:ca] = ca
              temp[:time] = d
              temp[:ho_va_ten] = sv.ho + " " + (sv.ho_dem || "") + " " + sv.ten
              temp[:ma_sinh_vien] = sv.ma_sinh_vien
              temp[:lop_hc] = sv.lop_hc
              result << temp
            end 
          end
        end
      end
    end
    return result
  end
  def siso 
    lop_mon_hoc_sinh_viens.count
  end
  def get_thuc_hanh
    # false la khong co thuc hanh
    return false if thuc_hanh == false
    return true    
  end
  def get_tkbs
    results = []    
    tkb_giang_viens.each do |l|
      results = results + l
    end
    return results
  end
  def get_days
    results = []   
    tkb_giang_viens.each do |l|
      results = results + JSON.parse(l.get_days)['ngay']
    end
    return results
  end
  def tong_so_tiet
    sum = 0
    get_days.each do |k|
      sum = sum + k["so_tiet"]
    end
    return sum
  end
  protected
  def update_trogiang
    if user 
      user.role = 'trogiang'
      user.save! rescue puts "Error"
    end    
  end
end
