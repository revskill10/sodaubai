require 'spec_helper'

describe TkbGiangVien do
  it "should be ok" do 
  	lop = LopMonHoc.new(ma_giang_vien: '123', ma_lop: 'l123', ma_mon_hoc: 'm123')
  	tkb = lop.tkb_giang_viens.new(tuan_hoc_bat_dau: 1, so_tiet: 3, so_tuan: 7, thu: 2, tiet_bat_dau: 1)
  	tkb.should be_valid
  	tkb.tuan_hoc_bat_dau.should == 1
  end
end
