class LopGhep < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_lop_ghep, :ma_mon_hoc, :nam_hoc

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop_ghep', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{ma_mon_hoc}'"]}
  has_many :tkb_giang_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  has_many :lop_mon_hoc_sinh_viens, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :dependent => :destroy, :conditions => proc {["ma_mon_hoc = '#{ma_mon_hoc}'"]}
  #has_many :sinh_viens, :through => :lop_mon_hoc_sinh_viens
  
end
