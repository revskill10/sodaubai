class LopMonHocSinhVien < ActiveRecord::Base

  default_scope :conditions => 'status is null or status = false'

  attr_accessible :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop_ghep', :primary_key => 'ma_lop' , :conditions => proc {"lop_mon_hocs.ma_mon_hoc = '#{self.ma_mon_hoc}'"}
  
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  
  
  has_many :lich_trinh_giang_days, :dependent => :nullify
  has_many :thong_bao_lop_hocs, :dependent => :nullify

  validates :ma_sinh_vien, :presence => true  
  after_create :set_ma_lop_ghep

  def set_ma_lop_ghep
    ma_lop = ma_lop_ghep
    save! rescue puts "Error lop ghep"
  end
  def convert_grade(diem)
    case diem
    when 9..10
      3
    when 7..8
      2
    when 5..6
      1    
    else
      0
    end
  end
  
  def diemqt
    (diemcc || 0) + convert_grade(diemtbkt || 0) + convert_grade(diem_thuc_hanh || 0)
  end
  def diemcc
    return DiemDanh.convert_dcc(100-(so_tiet_vang * 100 / lop_mon_hoc.so_tiet)) if so_tiet_vang and lop_mon_hoc.so_tiet
    #return self.so_tiet_vang
    return 4 unless so_tiet_vang
  end
  def diemtbkt
    ((lan1 || 0) + (lan2 || 0) + (lan3 || 0))/3
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
