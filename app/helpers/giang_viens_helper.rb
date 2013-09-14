#encoding: UTF-8
module GiangViensHelper
	def format_date2(d)
		return d.localtime.strftime("%Hh:%M ngày %d/%m/%Y")
	end
end
