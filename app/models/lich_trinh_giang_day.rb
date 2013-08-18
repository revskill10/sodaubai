# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  has_paper_trail
  attr_accessible :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :so_tiet_day, :so_vang, :ngay_day_moi, :ma_giang_vien_moi, :ma_mon_hoc_moi, :ten_mon_hoc_moi, :type, :status


  belongs_to :lop_mon_hoc
  has_many :diem_danhs do 
    def vang
      where("so_tiet_vang > 0")      
    end    
  end

  def doigio?
  	type == 4
  end
  def nghiday?
  	type == 1
  end
  def daybu?
  	type == 2
  end
  def daythay?
  	type == 3
  end  
  def gvpending?
  	status == 1
  end
  def gvaccept?
    status == 2
  end
  def qlpending?
  	status == 3
  end
  def qlaccept?
    status == 4
  end
  validates :ngay_day, :presence => true
  
  def score
  	return "#{rating_score} / #{ratings}" if ratings and ratings > 0
  	return "" unless  ratings or ratings == 0  		  	
  end

end
