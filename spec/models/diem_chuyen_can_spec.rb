require 'spec_helper'

describe DiemChuyenCan do   
  it "should have diem chuyen can pass" do 
  	sv = create(:sinh_vien)
  	lop = create(:lop_mon_hoc)
  	enroll = create(:lop_mon_hoc_sinh_vien, sinh_vien: sv, lop_mon_hoc: lop)
  	dcc = create(:diem_chuyen_can, sinh_vien: sv, lop_mon_hoc: lop)
  	dd1 = create(:diem_danh, sinh_vien: sv, lop_mon_hoc: lop, so_tiet_vang: 3)
  	dcc.tong_vang.should == 3
  end
end
