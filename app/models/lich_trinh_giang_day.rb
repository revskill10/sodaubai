# encoding: UTF-8
class LichTrinhGiangDay < ActiveRecord::Base
  has_paper_trail

  # Danh sach lich dang ky nghi day


  scope :nghiday, -> {where(loai: 1)}
  scope :nghidaychoduyet, -> {nghiday.where(status: 6)}
  scope :daybu, -> {where(loai: 2)}
  scope :daybuchoduyet, -> {daybu.where(status: 6)}
  scope :choduyet, -> {where(status: 6)}
  
  
  attr_accessible :ngay_day, :nhan_xet_buoi_hoc, :noi_dung_day, :so_tiet_day, :so_vang, :ngay_day_moi, :ma_giang_vien_moi, :ma_mon_hoc_moi, :ten_mon_hoc_moi, :loai, :status, :tuan_moi, :so_tiet_day_moi, :lop_mon_hoc_moi_id

  belongs_to :lop_bo_sung, :class_name => "LopMonHoc", :foreign_key => :lop_mon_hoc_moi_id
  belongs_to :lop_mon_hoc
  belongs_to :giang_vien_moi, :class_name => "GiangVien", :foreign_key => :ma_giang_vien_moi, :primary_key => :ma_giang_vien
  has_many :diem_danhs do 
    def vang
      where("so_tiet_vang > 0")      
    end    
  end

  def doigio?
  	loai == 4
  end
  def nghiday?
  	loai == 1
  end
  def daybu?
  	loai == 2
  end
  def daythay?
  	loai == 3
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
