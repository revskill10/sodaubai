class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_mon_hocs.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :lop_ghep, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_gheps.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ten_mon_hoc, :presence => true  
  
end
