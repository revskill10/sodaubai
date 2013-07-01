module BuoihocHelper
	def get_status(malop, mamon, msv, ngay)
		stv = DiemDanh.thongtin(malop, mamon, msv, ngay).first.try(:so_tiet_vang) || 0
		return stv > 0 ? true : false
	end
end
