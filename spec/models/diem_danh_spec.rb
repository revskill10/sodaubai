require 'spec_helper'

describe DiemDanh do  
  let(:lop){create(:lop_mon_hoc)}
  let(:dk1){create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop)}
  let(:dk2){create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: lop)}
  subject {create(:diem_danh, sinh_vien: dk1.sinh_vien, lop_mon_hoc: dk1.lop_mon_hoc)}   
  its(:so_tiet_vang) {should == 1}


  its("sinh_vien.ma_sinh_vien"){ should == dk1.sinh_vien.ma_sinh_vien}
  its("sinh_vien.lop_mon_hocs.size"){ should == 1}
  its("lop_mon_hoc.ma_lop") { should == lop.ma_lop}

  context "Khong tao diem danh cho sinh vien khong thuoc lop do" do 
  	let(:sv){create(:sinh_vien)}
  	subject(:dd){build(:diem_danh, lop_mon_hoc: lop, sinh_vien: sv)}

  	it { should_not be_valid }
  	
  end
  
end
