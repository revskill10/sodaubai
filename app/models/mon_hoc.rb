class MonHoc < ActiveRecord::Base
  attr_accessible :ma_mon_hoc, :ten_mon_hoc

  has_many :lop_mon_hocs, :dependent => :destroy, 
  	:foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  has_many :tkb_giang_viens, :dependent => :destroy,
  	:foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'

  validates :ma_mon_hoc, :ten_mon_hoc, :presence => true
  validates :ma_mon_hoc, :uniqueness => {:case_sensitive => false}


end
