FactoryGirl.define do 
	factory :mon_hoc do 
		sequence(:ma_mon_hoc) {|mmh| "monhoc#{mmh}"}
		sequence(:ten_mon) {|ten| "tenmon#{ten}"}
	end
	factory :lop_mon_hoc do 
		giang_vien
		mon_hoc
		nam_hoc "2012-2013"
		hoc_ky 2
		so_tiet 3
		so_tuan_hoc 13
		ngay_bat_dau Time.now
		ngay_ket_thuc Time.now + 3.weeks
		phong_hoc "C101"
		sequence(:ma_lop) {|ml| "malop#{ml}"}
	end
	factory :lop_mon_hoc_sinh_vien do 
		sinh_vien 
		lop_mon_hoc
		mon_hoc
		nam_hoc "2012-2013"
		hoc_ky 2
	end
end