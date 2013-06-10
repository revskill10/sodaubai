FactoryGirl.define do 
	factory :giang_vien do
		sequence(:ma_giang_vien) {|mgv| "mgv#{mgv}"}
		sequence(:ho_ten) {|ht| "hoten#{ht}"}
		hoc_vi "TienSi"
		hoc_ham "GiaoSu"
		ma_don_vi "DonVi"		
	end
	factory :nghi_day do 
		lop_mon_hoc
		giang_vien
		ngay_day DateTime.now
		phong "C101"
	end
	factory :day_thay do 
		lop_mon_hoc
		giang_vien
		ngay_day DateTime.now
		phong "C102"
	end
end