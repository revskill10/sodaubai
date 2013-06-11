require 'spec_helper'

describe LopMonHocSinhVien do    
  it "should include two sinhviens" do
  	lop1 = create(:lop_mon_hoc) 
  	sv1 = create(:sinh_vien)
  	sv2 = create(:sinh_vien)
  	enroll1 = create(:lop_mon_hoc_sinh_vien, sinh_vien: sv1, lop_mon_hoc: lop1)
  	enroll2 = create(:lop_mon_hoc_sinh_vien, sinh_vien: sv2, lop_mon_hoc: lop1)
  	lop1.sinh_viens.should have(2).records
  	
  	sv1.lop_mon_hocs.should have(1).records
  	sv2.lop_mon_hocs.should have(1).records
  end
end
