require 'spec_helper'

describe "diem_chuyen_cans/index" do
  before(:each) do
    assign(:diem_chuyen_cans, [
      stub_model(DiemChuyenCan,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tong_so_tiet => 2,
        :tong_so_tiet_vang => 3,
        :diem => 4
      ),
      stub_model(DiemChuyenCan,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tong_so_tiet => 2,
        :tong_so_tiet_vang => 3,
        :diem => 4
      )
    ])
  end

  it "renders a list of diem_chuyen_cans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
