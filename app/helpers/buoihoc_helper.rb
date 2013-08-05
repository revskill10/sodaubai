module BuoihocHelper
	def get_status(lop, sv, ngay)
		stv = get_vang(lop, sv, ngay)	
		return (stv and stv > 0) ? true : false
	end
	def get_phep(lop, sv, ngay)
		stv = lop.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien, ngay_vang: get_ngay(ngay)).first.try(:phep) || false
		return stv
	end
	def get_note(lop, sv, ngay)
		stv = lop.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien, ngay_vang: get_ngay(ngay)).first.try(:note) || ""
		return stv
	end
	def get_vang(lop, sv, ngay) 
		return lop.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien, ngay_vang: get_ngay(ngay)).first.try(:so_tiet_vang) || 0
	end
	def get_ngay(ngay)
		Time.zone.parse(ngay.to_s)
	end
	def str_to_ngay(str)
		DateTime.strptime(str, "%Y-%m-%d-%H-%M").change(:offset => Rational(7,24))
	end
end
