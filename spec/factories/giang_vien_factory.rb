FactoryGirl.define do 
	factory :giang_vien do
		sequence(:ma_giang_vien) {|mgv| "mgv#{mgv}"}
		sequence(:ho_ten) {|ht| "hoten#{ht}"}
		hoc_vi "TienSi"
		hoc_ham "GiaoSu"
		ma_don_vi "DonVi"		
	end
end