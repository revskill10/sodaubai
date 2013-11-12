# encoding : utf-8
module LopMonHocsHelper
	def selected(l)
		return l.group_id || 1
	end	
	def format_date2(d)
		return d.localtime.strftime("%Hh:%M ngày %d/%m/%Y")
	end
	def format_date3(d)
		return d.localtime.strftime("%Hh:%M %d/%m/%Y")
	end
end
