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
	end
	factory :thong_bao_lop_hoc do
		lop_mon_hoc
		sequence(:noi_dung) {|nd| "noi dung #{nd}"}
	end
	factory :lich_trinh_giang_day do
		lop_mon_hoc		
		ngay_day DateTime.now
		noi_dung_day "Noi dung ngay hom nay"
		so_tiet_day 3
		nhan_xet_buoi_hoc "Tot"
		phong "C101"
	end
	factory :diem_chuyen_can do
		sinh_vien
		lop_mon_hoc		
		diem 8
	end
	factory :diem_chi_tiet do
		sinh_vien
		lop_mon_hoc
		diem 8
		loai_diem "test"
		lan 3
	end
	factory :diem_danh do 
		sinh_vien
		lop_mon_hoc
		sequence(:ngay_vang){|n| DateTime.now + n.weeks }
		so_tiet_vang 1
	end
end