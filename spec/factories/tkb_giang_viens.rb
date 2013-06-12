# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tkb_giang_vien do
    giang_vien
    lop_mon_hoc
    mon_hoc
    phong "MyString"
    nam_hoc "MyString"
    hoc_ky 1
    tuan_hoc_bat_dau 1
    so_tuan 1
    ngay_bat_dau "2013-02-09"
    ngay_ket_thuc "2013-06-09"
    so_tiet 1
    tiet_bat_dau 3
    thu 3
  end
end
