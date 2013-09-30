# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lich_vi_pham do
    ngay_vi_pham "2013-09-27 14:28:54"
    lop_mon_hoc_id 1
    phong "MyString"
    tuan 1
    status 1
    note1 "MyText"
    note2 "MyText"
  end
end
