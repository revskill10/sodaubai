require 'json'
class GiangVien < ActiveRecord::Base
  attr_accessible :ho_ten, :hoc_ham, :hoc_vi, :ma_don_vi, :ma_giang_vien, :ma_loai, :days
  #association
  has_many :lop_mon_hocs, :foreign_key => 'ma_giang_vien', :dependent => :destroy, :primary_key => 'ma_giang_vien'
  has_many :tkb_giang_viens, :foreign_key => 'ma_giang_vien', :dependent => :destroy, :primary_key => 'ma_giang_vien' do 
    def with_lop(ma_lop, ma_mon, tuan)
      where("tkb_giang_viens.ma_lop = ? and tkb_giang_viens.ma_mon_hoc = ? and tkb_giang_viens.tuan_hoc_bat_dau <= ?", ma_lop, ma_mon, tuan)
    end
    def tuans
      group(:tuan_hoc_bat_dau).count
    end
  end

  has_many :lich_trinh_giang_days, :through => :lop_mon_hocs
  has_many :lich_bo_sungs, :class_name => "LichTrinhGiangDay", :foreign_key => :ma_giang_vien_moi, :primary_key => :ma_giang_vien
  
  has_one :user, :as => :imageable
  
  #validation
  validates :ho_ten, :ma_giang_vien, :presence => true
  validates :ma_giang_vien, :uniqueness => { :case_sensitive => false }
  def to_s
    "#{ho_ten}"
  end
  
  def get_days
    ngays = []
    if tkb_giang_viens.count > 0 
      tkb_giang_viens.all.each do |tkb|
        ngay = JSON.parse(tkb.days)["ngay"]
        ngays = ngays + ngay
      end
      ngays = ngays.sort_by {|h| [h["tuan"], h["time"]]}
    end
    return {:ngay => ngays}
  end

  def get_time(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def check_conflict(dt)
    days = get_days[:ngay]
    td = dt.to_i
    days.each do |d|
      day = get_time(d["time"][0]).to_i
      sogiay = d["so_tiet"] * 3000
      r1 = day
      r2 = day + sogiay
      #s1 = td - sogiay
      #s2 = td + sogiay
      r = r1..r2
      s = td..td
      if r.overlaps?(s) then return true end
    end
    lich_trinh_giang_days.each do |l|
      if l.ngay_day_moi
        day = l.ngay_day_moi.localtime.to_i
        sogiay = 9000
        r1 = day
        r2 = day + sogiay
        #s1 = td - sogiay
        #s2 = td + sogiay
        r = r1..r2
        s = td..td
        if r.overlaps?(s) then return true end
      end
    end
    return false
  end

end
