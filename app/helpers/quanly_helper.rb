#encoding: UTF-8
module QuanlyHelper
	def get_status(s)
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
end
