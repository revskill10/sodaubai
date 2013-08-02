class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop_ghep' , :conditions => proc {"lop_mon_hocs.ma_mon_hoc = '#{self.ma_mon_hoc}'"}
  
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  delegate :so_tiet , :to => :lop_mon_hoc
  has_many :diem_danhs, :dependent => :nullify  
  has_many :lich_trinh_giang_days, :dependent => :nullify
  has_many :thong_bao_lop_hocs, :dependent => :nullify

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ten_mon_hoc, :presence => true  
  
  def diemqt
    (diemcc || 0) + (diemtbkt || 0) + (diem_thuc_hanh || 0)
  end
  def diemcc
    DiemDanh.convert_dcc(so_tiet_vang * 100 / so_tiet)
  end
  def diemtbkt
    (lan1 + lan2 + lan3)/3
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
