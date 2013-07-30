module BuoihocHelper
	def get_status(malop, mamon, msv, ngay)
		stv = DiemDanh.thongtin(malop, mamon, msv, ngay).first.try(:so_tiet_vang) || 0
		return (stv and stv > 0) ? true : false
	end
	def get_phep(malop, mamon, msv, ngay)
		stv = DiemDanh.thongtin(malop, mamon, msv, ngay).first.try(:phep) || false
		return stv
	end
	def get_ngay(ngay)
		Time.zone.parse(ngay.to_s)
	end
	def str_to_ngay(str)
		DateTime.strptime(str, "%Y-%m-%d-%H-%M").change(:offset => Rational(7,24))
	end
end
