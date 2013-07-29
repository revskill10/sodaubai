class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_mon_hocs.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :lop_ghep, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_gheps.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'


  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ten_mon_hoc, :presence => true    
  validate :ma_sinh_vien, :scope => [:ma_lop, :ma_mon_hoc], :unique => true
  
  
  def diemqt
    (diem_chuyen_can || 0) + (diem_tbkt || 0) + (diem_thuc_hanh || 0)
  end
  def conflict?
  	tkbs = sinh_vien.get_tkbs
  	mtkbs = lop_mon_hoc.get_tkbs
  	res = false
  	tkbs.each do |tkb|
  		break if res == true 
  		mtkbs.each do |tk|
  			if tkb.schedule.conflicts_with?(tk.schedule) then
  				res = true
  				break 
  			end
  		end
  	end
  	return res  	
  end

  
end
