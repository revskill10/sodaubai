# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

mon = FactoryGirl.create(:mon_hoc, ma_mon_hoc: "monhoc1")
gv = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth")
svs = FactoryGirl.create_list(:sinh_vien, 10)

lop1 = FactoryGirl.create(:lop_mon_hoc, ma_mon_hoc: mon.ma_mon_hoc, giang_vien: gv)
svs.each do |sv|
	FactoryGirl.create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop1, ma_mon_hoc: mon.ma_mon_hoc, sinh_vien: sv)
end
tkbs = FactoryGirl.create_list(:tkb_giang_vien, 3, giang_vien: gv, 
	lop_mon_hoc: lop1, ma_mon_hoc: mon.ma_mon_hoc
	)
