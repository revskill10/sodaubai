# encoding: UTF-8
require 'active_support/time'
class TkbGiangVien < ActiveRecord::Base
  
  include IceCube
  attr_accessible :hoc_ky, :ma_giang_vien, :ma_lop, :ma_mon_hoc, :nam_hoc, :ngay_bat_dau, :ngay_ket_thuc, :phong, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau, :ten_giang_vien, :ten_mon_hoc, :days, :loai

  

  belongs_to :giang_vien, :foreign_key => 'ma_giang_vien', :primary_key => 'ma_giang_vien'
  belongs_to :lop_mon_hoc
  belongs_to :mon_hoc, :foreign_key => 'ma_mon_hoc', :primary_key => 'ma_mon_hoc'
  
  validates :ngay_bat_dau, :ngay_ket_thuc, :so_tiet, :so_tuan, :thu, :tiet_bat_dau, :tuan_hoc_bat_dau, :presence => true
  TIET = {1 => [6,30], 2 => [7,20], 3 => [8,10],
  	4 => [9,5], 5 => [9,55], 6 => [10, 45],
  	7 => [12,30], 8 => [13,20], 9 => [14,10],
  	10 => [15, 5], 11 => [15, 55], 12 => [16, 45],
  	13 => [18, 0], 14 => [18, 50], 15 => [19,40], 16 => [20,30]}
  THU2 = {2 => "Thứ 2", 3 => "Thứ 3", 4 => "Thứ 4", 5 => "Thứ 5", 6 => "Thứ 6", 7 => "Thứ 7", 8 => "Chủ nhật"}
  THU = {2 => :monday, 3 => :tuesday, 4 => :wednesday, 5 => :thursday, 6 => :friday, 7 => :saturday, 8 => :sunday}
  

  
  def desc
    "Lớp: " + ma_lop + ", Môn: " + ten_mon_hoc + ", Thứ: " + thu + ", Tiết bắt đầu: " + tiet_bat_dau
  end
  
  def check_conflict?(tkb)
    t1 = tuan_hoc_bat_dau..tuan_hoc_bat_dau+so_tuan
    t2 = tkb.tuan_hoc_bat_dau..tkb.tuan_hoc_bat_dau+tkb.so_tuan
    ti1 = tiet_bat_dau..tiet_bat_dau+so_tiet
    ti2 = tkb.tiet_bat_dau..tkb.tiet_bat_dau+tkb.so_tiet
    return false if (t1.to_a & t2.to_a).empty?
    return false if thu != tkb.thu
    return false if (ti1.to_a & ti2.to_a).empty?
  end
  def schedule
    new_schedule = Schedule.new(ngay_bat_dau)
    new_schedule.add_recurrence_rule(Rule.daily.day(THU[thu]).hour_of_day(TIET[tiet_bat_dau][0]).minute_of_hour(TIET[tiet_bat_dau][1]).second_of_minute(0).until(ngay_ket_thuc))    
    new_schedule
  end
  def get_days
    x = schedule.all_occurrences
    y = x.each_slice(x.count/so_tuan).to_a
    z = y.each_with_index.map {|m,t| {:tuan => tuan_hoc_bat_dau + t, :time => m, :lop => lop_mon_hoc.id, :ma_lop => ma_lop, :ma_mon_hoc => ma_mon_hoc , :thu => thu, :so_tiet => so_tiet, :tiet_bat_dau => tiet_bat_dau,
    :ten_mon_hoc => ten_mon_hoc, :phong => phong, :ma_giang_vien => lop_mon_hoc.ma_giang_vien, :ten_giang_vien => lop_mon_hoc.ten_giang_vien } }
    return {:ngay => z}.to_json
  end
  
end
