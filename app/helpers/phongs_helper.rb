#encoding: utf-8
module PhongsHelper
	def format_date2(d)
		return d.localtime.strftime("%Hh:%M ngày %d/%m/%Y")
	end
end