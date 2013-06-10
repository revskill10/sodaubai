require 'spec_helper'

describe NghiDay do
  it "should fail without ngay day" do 
    nd = build(:nghi_day, ngay_day: nil)
    nd.should_not be_valid
  end
  it "should pass nghi day" do 
  	gv = create(:giang_vien)
  	lop = create(:lop_mon_hoc)
  	nd = create(:nghi_day, ngay_day: DateTime.now)
  	nd.phong.should == "C101"
    nd.nam_hoc.should == lop.nam_hoc
  end
end
