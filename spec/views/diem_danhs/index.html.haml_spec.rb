require 'spec_helper'

describe "diem_danhs/index" do
  before(:each) do
    assign(:diem_danhs, [
      stub_model(DiemDanh,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :so_tiet_vang => 2
      ),
      stub_model(DiemDanh,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :so_tiet_vang => 2
      )
    ])
  end

  it "renders a list of diem_danhs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
