require 'spec_helper'

describe LopMonHoc do
  
  it "should be ok" do   	
  	l = LopMonHoc.create(ma_giang_vien: "0123",ma_lop: "malop",ma_mon_hoc: "mamonhoc",ten_mon_hoc: "ddd")
  	l.ten_mon_hoc.should == "ddd"
  end
end
