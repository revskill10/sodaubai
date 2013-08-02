class DiemChuyenCan < ActiveRecord::Base
  attr_accessible :ma_mon, :ma_lop, :ma_sinh_vien

  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  delegate :so_tiet, :to => :lop_mon_hoc
  
  

  def self.convert_grade(diem)
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

  

end
