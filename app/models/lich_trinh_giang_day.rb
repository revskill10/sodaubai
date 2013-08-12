# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  attr_accessible :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :phong, :so_tiet_day, :so_vang, :siso, :sv

  belongs_to :lop_mon_hoc
  

  validates :ngay_day, :presence => true
  
  def score
  	return "#{rating_score} / #{ratings}" if ratings and ratings > 0
  	return "" unless  ratings or ratings == 0  		  	
  end
end
