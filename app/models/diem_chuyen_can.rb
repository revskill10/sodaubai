class DiemChuyenCan < ActiveRecord::Base
  attr_accessible :diem, :ma_mon, :ma_lop, :ma_sinh_vien

  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :lop_mon_hoc_sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'","ma_lop = '#{self.ma_lop}'"]}
  delegate :so_tiet, :to => :lop_mon_hoc
  validate :ma_lop, :ma_mon, :ma_sinh_vien, :presence => true
  validate :ma_sinh_vien, :scope => [:ma_lop, :ma_mon], :unique => true
  after_save :set_default


  def convert_grade(percent)
    case percent
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

  protected
  def set_default
    l = lop_mon_hoc_sinh_vien
    if l 
      l.diem_chuyen_can = convert_grade(diem*100 || 0)
      l.diem_qua_trinh = l.diemqt
      l.save! rescue "save error"
    end

  end

  
end
