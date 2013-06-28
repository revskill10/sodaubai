# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

=begin
 mon = FactoryGirl.create(:mon_hoc, ma_mon_hoc: "monhoc1")
mon2 = FactoryGirl.create(:mon_hoc, ma_mon_hoc: "monhoc2")
gv = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth")
svs = FactoryGirl.create_list(:sinh_vien, 10)

lop1 = FactoryGirl.create(:lop_mon_hoc, ma_mon_hoc: mon.ma_mon_hoc, giang_vien: gv)
svs.each do |sv|
	FactoryGirl.create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop1, ma_mon_hoc: mon.ma_mon_hoc, sinh_vien: sv)
end
tkbs = FactoryGirl.create_list(:tkb_giang_vien, 3, giang_vien: gv, 
	lop_mon_hoc: lop1, ma_mon_hoc: mon.ma_mon_hoc, tuan_hoc_bat_dau: 23
	)

svs2 = FactoryGirl.create_list(:sinh_vien, 10)
lop2 = FactoryGirl.create(:lop_mon_hoc, ma_mon_hoc: mon2.ma_mon_hoc, giang_vien: gv)
svs2.each do |sv|
	FactoryGirl.create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop2, ma_mon_hoc: mon2.ma_mon_hoc, sinh_vien: sv)
end
tkbs2 = FactoryGirl.create_list(:tkb_giang_vien, 3, giang_vien: gv, 
	lop_mon_hoc: lop2, ma_mon_hoc: mon2.ma_mon_hoc, tuan_hoc_bat_dau: 33, so_tuan: 10,
	ngay_bat_dau: Date.strptime("2013-09-09","%Y-%m-%d") ,
	ngay_ket_thuc: Date.strptime("2013-12-09","%Y-%m-%d") 
	)
=end
Tuan.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('tuans')
LopMonHoc.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('lop_mon_hocs')
GiangVien.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('giang_viens')
TkbGiangVien.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('tkb_giang_viens')
SinhVien.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('sinh_viens')
LopMonHocSinhVien.delete_all	
ActiveRecord::Base.connection.reset_pk_sequence!('lop_mon_hoc_sinh_viens')
