require 'spec_helper'
include Warden::Test::Helpers
 Warden.test_mode!
module RequestHelpers
  def create_logged_in_user
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
		user = create(:user, imageable: gv)
		login(user)
		user
	
  end
 
  def login(user)   
    login_as user, scope: :user
  end
end