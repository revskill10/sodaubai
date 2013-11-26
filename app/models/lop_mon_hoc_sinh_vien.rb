require 'hpu'
class LopMonHocSinhVien < ActiveRecord::Base
  include PublicActivity::Common
  include Comparable
  include HPU

  default_scope order('ten, ho_dem, ho, ngay_sinh')
  default_scope :conditions => 'status is null or status = false'
  

  attr_accessible :ma_lop, :ma_lop_ghep, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten, :ho, :lop_ghep, :tin_chi, :creator, :ngay_sinh

  belongs_to :lop_mon_hoc
  
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :nguoi_tao, :class_name => "User", :foreign_key => :creator, :primary_key => :id
  
  has_many :lich_trinh_giang_days, :dependent => :nullify
  has_many :thong_bao_lop_hocs, :dependent => :nullify

  validates :ma_sinh_vien,  :presence => true  
  
  def convert_dcc(diem)
    case diem
    when 100
      4
    when 90..99
      3
    when 80..89
      2
    when 70..79
      1
    else
      0
    end
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
  def convert_kocothuchanh(diem)
    case diem 
    when 10
      6
    when 9
      5
    when 8
      4
    when 7
      3
    when 6
      2
    when 5
      1
    else
      0
    end
  end
  def hodemdaydu
    (ho || "") + " " + (ho_dem || "")
  end
  def phieudiem
    "GL, TC" if lop_ghep == true and diem_chuyen_can == 0
    "GL" if lop_ghep == true and diem_chuyen_can > 0
    "TC" if !(lop_ghep == true) and diem_chuyen_can == 0
    ""
  end
  def tong_so_tiet    
    (lop_mon_hoc.so_tiet_phan_bo if lop_mon_hoc.so_tiet_phan_bo and lop_mon_hoc.so_tiet_phan_bo.to_i > 0) || lop_mon_hoc.khoi_luong_phan_bo || 1
  end  
  def diemth2
    if lop_mon_hoc.get_thuc_hanh
      return diem_thuc_hanh.round(0).to_i if lop_mon_hoc.thang3 == true
      convert_grade((diem_thuc_hanh.round(0).to_i if diem_thuc_hanh) || 0)
    else
      0
    end
  end
  def diemqt    
    return (diem_chuyen_can || 0) + (diem_thuc_hanh || 0) + (diem_tbkt || 0) if lop_mon_hoc.thang3
    return 0 if diemcc == 0 and diem_chuyen_can == 0
    (diem_chuyen_can || diemcc || 0) + diemtbkt + diemth2
  end
  def percent
    return 100 if so_tiet_vang.nil?
    sovang = so_tiet_vang - so_vang_co_phep
    sv = (tong_so_tiet - sovang) / tong_so_tiet.to_f
    (sv * 100 ).round(2)
  end
  def diemcc
    return convert_dcc(percent.to_i) if so_tiet_vang and lop_mon_hoc.so_tiet
    #return self.so_tiet_vang
    return 4 unless so_tiet_vang
  end
  def diemtbkt
    return convert_grade((diemtbkt1.round(0).to_i if diemtbkt1) || 0)  if lop_mon_hoc.get_thuc_hanh == true     
    return convert_kocothuchanh( (diemtbkt1.round(0).to_i if diemtbkt1) || 0 )  if lop_mon_hoc.get_thuc_hanh == false     
  end
  def diemtbkt1
    if lop_mon_hoc.so_lan_kt.nil? or lop_mon_hoc.so_lan_kt == 0 then return 0
    elsif lop_mon_hoc.so_lan_kt > 0 and lop_mon_hoc.so_lan_kt <=5
      sum = 0
      lop_mon_hoc.so_lan_kt.times do |t|
        sum = sum + (send("lan#{t+1}".to_sym) || 0)
      end
      #((lan1 || 0) + (lan2 || 0) + (lan3 || 0) + (lan4 || 0) + (lan5 || 0))/ (sl)
      return sum / lop_mon_hoc.so_lan_kt
    end
    return 0
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

