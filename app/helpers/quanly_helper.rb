#encoding: UTF-8
module QuanlyHelper
	def get_status2(s)
		case s
		when 3
			return "Đã duyệt"
		when 4
			return "Không duyệt"
		end
	end
	def format_date(d)
		return d.strftime("%H:%M ngày %d/%m/%Y")
	end
	def ca_trong(v, ca)
		lich = v.select {|p| p[:ca] == ca}.first
		return {:res => nil, :val => "<p><br/><br/><br/></p>"} unless lich
		return {:res => 1, :val => "<p style='text-align:center;'><span style='font-weight:bold;'>#{lich[:ten_giang_vien]}</span><br/>#{lich[:ten_mon_hoc]}<br/>#{lich[:ma_lop]}</p>"}
	end
end
