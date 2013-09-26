#encoding: UTF-8
module MonitorHelper	
	def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24)).to_date
  end
  def to_zdatetime(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def current_tuan
    Tuan.all.detect {|t| t.tu_ngay.localtime <= DateTime.now and t.den_ngay.localtime >= DateTime.now }
  end
  def from_zdate(str)
    str1 = str.split("-").to_a
     str2 = str1[0]+"-"+str1[1]+"-"+str1[2]+"T"+str1[3]+":"+str1[4]+":00Z"
     return str2
  end
  def check_trucnhat(nhom, sv)
    return false unless nhom
    nhom.include?(sv)
  end
  def getdiemdanh(lich)
    return "Chưa điểm danh" unless lich
    (lich.siso - lich.diem_danhs.vang.count) if lich
  end
end
