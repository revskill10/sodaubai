module BuoihocHelper
	def so(s)
		return s.to_s if s >= 100
		if s < 10
			return "00" + s.to_s
		elsif s < 100
			return "0" + s.to_s		
		end				
	end
	def get_rate(lich)
		return "#{lich.rating_score}" + "/" + "#{lich.ratings}"
	end
	def get_status(lich, sv)
		stv = get_vang(lich, sv)	
		return (stv and stv > 0) ? true : false
	end
	def get_phep(lich, sv)
		stv = lich.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien).first.try(:phep) || false
		return stv
	end
	def get_note(lich, sv)
		stv = lich.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien).first.try(:note) || ""
		return stv
	end
	def get_vang(lich, sv) 
		return lich.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien).first.try(:so_tiet_vang) || 0
	end
	def get_tiet_nghi(lich, i)
		return false unless lich.tiet_nghi
		tn = lich.tiet_nghi.split(",").to_a
		return true if tn.include?(i.to_s)
		return false
	end
	def get_ngay(ngay)
		Time.zone.parse(ngay.to_s)
	end
	def str_to_ngay(str)
		DateTime.strptime(str, "%Y-%m-%d-%H-%M").change(:offset => Rational(7,24))
	end
	def get_tuan(dt)
		Tuan.all.detect {|t| t.tu_ngay.localtime <= dt.change(:offset => Rational(7,24)) and t.den_ngay.localtime >= dt.change(:offset => Rational(7,24)) }
	end
end
