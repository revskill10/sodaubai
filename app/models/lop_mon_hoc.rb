class LopMonHoc < ActiveRecord::Base
  acts_as_xlsx
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :ten_giang_vien, :ten_mon_hoc, :dssv, :group

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'

  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  has_many :tkb_giang_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}' and ma_giang_vien = '#{self.ma_giang_vien}'"]} do 
    def with_tuan(tuan)
      where("tkb_giang_viens.tuan_hoc_bat_dau = ?",tuan)
    end
  end
  has_many :lop_gheps, :foreign_key => 'ma_lop_ghep', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{ma_mon_hoc}'"]}


  has_many :thong_bao_lop_hocs, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}' and ma_giang_vien = '#{self.ma_giang_vien}'"]}

  has_many :lich_trinh_giang_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :diem_danhs, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :diem_chuyen_cans, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :diem_chi_tiets, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]} do 
    def diem_thuc_hanh
      where("diem_chi_tiets.loai_diem = ?", '1')
    end
    def diem_kiem_tra
      where("diem_chi_tiets.loai_diem = ?", '2')
    end
  end
  has_many :groups, :dependent => :destroy
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  #has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  has_many :nghi_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :day_thays, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  validates :ma_giang_vien, :ma_lop, :ma_mon_hoc, :presence => true
  validates_uniqueness_of :ma_lop, :scope => [:ma_giang_vien, :ma_mon_hoc]
  def get_sinh_viens
    gheps = lop_mon_hoc_sinh_viens
    if lop_gheps.empty? then 
      return gheps    
    else
      lop_gheps.each do |lg|
        gheps = gheps + lg.lop_mon_hoc_sinh_viens
      end      
    end
    return gheps
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
end
