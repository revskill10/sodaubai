class LopMonHoc < ActiveRecord::Base
  
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'

  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  has_many :tkb_giang_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}' and ma_giang_vien = '#{self.ma_giang_vien}'"]}

  has_many :thong_bao_lop_hocs, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  has_many :lich_trinh_giang_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :diem_danhs, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :diem_chuyen_cans, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  has_many :nghi_days, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  has_many :day_thays, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}

  validates :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong_hoc, :so_tiet, :so_tuan_hoc, :presence => true
  validates :ma_lop, :uniqueness => {:case_sensitive => false}
  
  
end
