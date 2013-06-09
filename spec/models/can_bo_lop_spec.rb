require 'spec_helper'

describe CanBoLop do
  let(:sinh_vien) { build(:sinh_vien) }
  subject { create(:can_bo_lop, :sinh_vien => sinh_vien)}
  its(:ma_sinh_vien) {should include("msv")}
  its(:nam_hoc) {should == "2012-2013"}
  its(:sinh_vien) {should respond_to(:lop_hc)}
end
