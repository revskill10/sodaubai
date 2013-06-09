require 'spec_helper'

describe "diem_chuyen_cans/show" do
  before(:each) do
    @diem_chuyen_can = assign(:diem_chuyen_can, stub_model(DiemChuyenCan,
      :ma_sinh_vien => "Ma Sinh Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :tong_so_tiet => 2,
      :tong_so_tiet_vang => 3,
      :diem => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Sinh Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
