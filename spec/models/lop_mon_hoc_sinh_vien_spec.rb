require 'spec_helper'

describe LopMonHocSinhVien do    
  it "should include two sinhviens" do
  	lop1 = create(:lop_mon_hoc) 
  	sv1 = create(:sinh_vien)
  	sv2 = create(:sinh_vien)
  	enroll1 = create(:lop_mon_hoc_sinh_vien, sinh_vien: sv1, lop_mon_hoc: lop1)
  	enroll2 = create(:lop_mon_hoc_sinh_vien, sinh_vien: sv2, lop_mon_hoc: lop1)
  	lop1.sinh_viens.should include(sv1)
  	lop1.sinh_viens.should include(sv2)
  	enroll1.nam_hoc.should == lop1.nam_hoc
  end
end
