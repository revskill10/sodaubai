require 'spec_helper'

describe "tkb_giang_viens/index" do
  before(:each) do
    assign(:tkb_giang_viens, [
      stub_model(TkbGiangVien,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :phong => "Phong",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tuan_hoc_bat_dau => 2,
        :so_tuan => 3,
        :so_tiet => 4,
        :tiet_bat_dau => 5,
        :thu => 6
      ),
      stub_model(TkbGiangVien,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :phong => "Phong",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tuan_hoc_bat_dau => 2,
        :so_tuan => 3,
        :so_tiet => 4,
        :tiet_bat_dau => 5,
        :thu => 6
      )
    ])
  end

  it "renders a list of tkb_giang_viens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Giang Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Phong".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
