class LopMonHoc < ActiveRecord::Base
  
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :ten_giang_vien, :ten_mon_hoc, :dssv

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
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  has_many :nghi_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :day_thays, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  validates :ma_giang_vien, :ma_lop, :ma_mon_hoc, :presence => true
  validates_uniqueness_of :ma_lop, :scope => [:ma_giang_vien, :ma_mon_hoc]
  def get_sinh_viens
    gheps = []
    if lop_gheps.empty? then 
      return sinh_viens
    else
      lop_gheps.each do |lg|
        gheps = gheps + lg.sinh_viens
      end
      return gheps
    end
  end

end
