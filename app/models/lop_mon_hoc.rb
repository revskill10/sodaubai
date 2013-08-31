class LopMonHoc < ActiveRecord::Base
  has_paper_trail
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :ten_giang_vien, :ten_mon_hoc, :dssv, :group, :user_id, :so_lan_kt, :thuc_hanh


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

  has_many :lich_trinh_giang_days, :dependent => :nullify
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

  after_save :update_trogiang
  def to_s
    "#{ma_lop} #{ten_mon_hoc} #{ma_giang_vien}"
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
