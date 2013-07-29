class DiemChiTiet < ActiveRecord::Base
  attr_accessible :diem, :hoc_ky, :lan, :loai_diem, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lop_mon_hoc_sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'","ma_lop = '#{self.ma_lop}'"]}
  validates :ma_mon_hoc, :ma_lop, :ma_sinh_vien, :presence => true
  
  after_save :set_default
  GRADE = {9 => 3, 10 => 3, 7 => 2, 8 => 2, 5 => 1, 6 => 1, 4 => 0, 3 => 0, 2 => 0, 1 => 0, 0 => 0}
  def convert_grade(grade)
  	case grade
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

  protected
  def diem_thuc_hanh
    (diem || 0 if loai_diem == "2") 
  end
  def diem_tbkt
    DiemChiTiet.where(ma_lop: ma_lop, ma_mon_hoc: ma_mon_hoc,lan: [1,2,3], loai_diem: "1").average(:diem) || 0
  end
  def set_default
    l = lop_mon_hoc_sinh_vien
    if l 
      l.diem_tbkt = convert_grade(diem_tbkt || 0)
      l.diem_thuc_hanh = convert_grade(diem_thuc_hanh || 0)
      l.diem_qua_trinh = l.diemqt
      l.save! rescue "Diem qua trinh error"
    end
  end
end
