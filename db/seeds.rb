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
FactoryGirl.create(:lop_mon_hoc, giang_vien: gv)
FactoryGirl.create(:lop_mon_hoc, giang_vien: gv2)