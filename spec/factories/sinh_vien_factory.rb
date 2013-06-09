FactoryGirl.define do
	
	factory :sinh_vien do
		gioi_tinh true
		sequence(:lop_hc) { |lhc| "lophc#{lhc}"}
		sequence(:ma_sinh_vien) { |msv| "msv#{msv}" }
		sequence(:ten) {|ten| "ten#{ten}" }
		sequence(:ma_khoa_hoc) {|ten| "khoahoc#{ten}" }
		sequence(:ma_he_dao_tao) {|ten| "hedaotao#{ten}" }
		sequence(:ma_nganh) {|ten| "nganh#{ten}" }
	end
	
	
	factory :can_bo_lop do
		sinh_vien
		sequence(:ma_lop) {|ml| "lop#{ml}"}
		sequence(:ma_mon_hoc) {|mmh| "monhoc#{mmh}"}
		nam_hoc "2012-2013"
		hoc_ky 2
	end

end
