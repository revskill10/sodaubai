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
end
