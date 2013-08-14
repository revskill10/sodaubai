class LopMonHoc < ActiveRecord::Base
  
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
  belongs_to :user
  

  has_many :thong_bao_lop_hocs, :dependent => :destroy

  has_many :lich_trinh_giang_days, :dependent => :nullify
  has_many :diem_danhs, :dependent => :nullify
  
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_lop_ghep', :primary_key => 'ma_lop', :dependent => :nullify, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  #has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  has_many :nghi_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :day_thays, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  validates :ma_giang_vien, :ma_lop, :ma_mon_hoc, :presence => true
  validates_uniqueness_of :ma_lop, :scope => [:ma_giang_vien, :ma_mon_hoc]
  
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
    tkbs = tkb_giang_viens.uniq {|tk| "#{tk.thu}-#{tk.tiet_bat_dau}-#{tk.tuan_hoc_bat_dau}-#{tk.tiet_bat_dau}-#{tk.phong}-#{tk.ma_lop}-#{tk.ma_mon_hoc}"}
    tkbs.each do |l|
      results = results + l
    end
    return results
  end
  def get_days
    results = []
    tkbs = tkb_giang_viens.uniq {|tk| "#{tk.thu}-#{tk.tiet_bat_dau}-#{tk.tuan_hoc_bat_dau}-#{tk.tiet_bat_dau}-#{tk.phong}-#{tk.ma_lop}-#{tk.ma_mon_hoc}"}
    tkbs.each do |l|
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
