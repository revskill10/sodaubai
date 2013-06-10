require 'spec_helper'

describe DiemChiTiet do
  let(:sinh_vien) {create(:sinh_vien)}
  let(:lop){create(:lop_mon_hoc)}
  subject(:diem_chi_tiet) {create(:diem_chi_tiet, lop_mon_hoc: lop, sinh_vien: sinh_vien)}
  its(:ma_sinh_vien){ should == sinh_vien.ma_sinh_vien}
  its(:ma_lop) { should == lop.ma_lop}
  its(:nam_hoc) { should == lop.nam_hoc}
end
