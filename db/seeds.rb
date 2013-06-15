# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

gv = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth")
gv2 = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth2")
svs = FactoryGirl.create_list(:sinh_vien, 10)

lop1 = FactoryGirl.create(:lop_mon_hoc, giang_vien: gv)
svs.each do |sv|
	FactoryGirl.create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop1, sinh_vien: sv)
end
lop2 = FactoryGirl.create(:lop_mon_hoc, giang_vien: gv)
tkbgv = FactoryGirl.create(:tkb_giang_vien, giang_vien: gv, lop_mon_hoc: lop1, ngay_bat_dau: "2013-02-09", ngay_ket_thuc: "2013-06-09")
tkbgv2 = FactoryGirl.create(:tkb_giang_vien, giang_vien: gv, lop_mon_hoc: lop2, ngay_bat_dau: "2013-03-10", ngay_ket_thuc: "2013-09-10", tiet_bat_dau: 4, thu: 4)