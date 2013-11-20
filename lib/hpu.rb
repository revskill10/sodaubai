# encoding: utf-8
require 'date'
module HPU
	class LSVCompare
		include Comparable
		attr_accessor :stt, :msv, :ma_lop_hanh_chinh, :diem_chuyen_can, :diem_thuc_hanh, :diem_tbkt, :diem_qua_trinh, :ten, :ho_dem, :ho, :ngaysinh, :lop_ghep
		def initialize(h)
			@lop_ghep = h["lop_ghep"]
			@ten = h["ten"]
			@ho_dem = h["ho_dem"]
			@ho = h["ho"]
			@ngaysinh = h["ngay_sinh"]
			@stt = h["stt"]
			@msv = h["ma_sinh_vien"]
			@ma_lop_hanh_chinh = h["ma_lop_hanh_chinh"]
			@diem_chuyen_can = h["diem_chuyen_can"]
			@diem_thuc_hanh = h["diem_thuc_hanh"]
			@diem_tbkt = h["diem_tbkt"]
			@diem_qua_trinh = h["diem_qua_trinh"]
		end
		def hovaten
			@ho + (" " + @ho_dem if @ho_dem) + " " + @ten
		end
		def <=> other
		    t1 = mycompare(self.ten, other.ten)
		    t2 = mycompare(self.ho_dem, other.ho_dem)
		    t3 = mycompare(self.ho, other.ho)
		    t4 = Date.strptime(self.ngaysinh,"%d/%m/%Y") <=> Date.strptime(other.ngaysinh, "%d/%m/%Y")
		    return t1 if t1 != 0
		    return t2 if t2 != 0
		    return t3 if t3 != 0
		    return t4 if t4 != 0
		    return 0
		end
		private
		def mycompare(s1, s2)
			if s1.nil? and s2 then return -1 end
			if s1 and s2.nil? then return 1 end
			if s1.nil? and s2.nil? then return 0 end
			s1 = s1.strip
			s2 = s2.strip
			
			if s1.length == 0 and s2.length == 0 then  return 0 end
			if s1.length == 0 then return -1 end
			if s2.length == 0 then return 1 end
			
			ss = "AÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬBCDĐEÈÉẺẼẸÊỀẾỂỄỆFGHIÌÍỈĨỊJKLMNOÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢPQRSTUÙÚỦŨỤƯỪỨỬỮỰVWXYỲÝỶỸỴZ "
			ss2 = "aàáảãạăằắẳẵặâầấẩẫậbcdđeèéẻẽẹêềếểễệfghiìíỉĩịjklmnoòóỏõọôồốổỗộơờớởỡợpqrstuùúủũụưừứửữựvwxyỳýỷỹỵz "
					
			minLength = s1.length
			if (minLength > s2.length) then  minLength = s2.length end
			i = 0								
			while i < minLength 			
				ch1 = s1[i]
				ch2 = s2[i]
				
				i1 = ss.index(ch1)		
				i2 = ss.index(ch2)	
				i1 = ss2.index(ch1) if i1.nil?
				i2 = ss2.index(ch2) if i2.nil?
				return -1 if i1 < i2
				return 1 if i2 < i1
				i += 1
			end	
			if i == s1.length and i == s2.length then return 0 end
			if i == s1.length then return -1 end
			if i == s2.length then return 1 end	
			return 0
		end
	end

end