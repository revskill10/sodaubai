require 'spec_helper'

describe ThongBaoLopHoc do
  let(:giang_vien) {create(:giang_vien)}
  let(:lop_mon_hoc) {create(:lop_mon_hoc, :giang_vien => giang_vien)}
  subject(:thong_bao) {create(:thong_bao_lop_hoc, :lop_mon_hoc => lop_mon_hoc)}
  it { should belong_to(:lop_mon_hoc)}
  its(:ma_giang_vien) {should == giang_vien.ma_giang_vien}

  it "tao thong bao moi" do 
  	thong_bao.reload.lop_mon_hoc.ma_lop.should == lop_mon_hoc.ma_lop
  end
end
