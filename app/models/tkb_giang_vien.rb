require 'active_support/time'
class TkbGiangVien < ActiveRecord::Base
  include IceCube
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop'
  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'

  validates :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau, :presence => true
  TIET = {1 => [6,30], 2 => [7,20], 3 => [8,10],
  	4 => [9,5], 5 => [9,55], 6 => [10, 45],
  	7 => [12,30], 8 => [13,20], 9 => [14,10],
  	10 => [15, 5], 11 => [15, 55], 12 => [16, 45],
  	13 => [18, 0], 14 => [18, 50], 15 => [19,40], 16 => [20,30]}
  THU = {2 => :monday, 3 => :tuesday, 4 => :wednesday, 5 => :thursday, 6 => :friday, 7 => :saturday, 8 => :sunday}
  def schedule
    new_schedule = Schedule.new(ngay_bat_dau)
    new_schedule.add_recurrence_rule(Rule.daily.day(THU[thu]).hour_of_day(TIET[tiet_bat_dau][0]).minute_of_hour(TIET[tiet_bat_dau][1]).second_of_minute(0).until(ngay_ket_thuc))    
    new_schedule
  end
end
