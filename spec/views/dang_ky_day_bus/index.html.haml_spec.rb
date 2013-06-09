require 'spec_helper'

describe "dang_ky_day_bus/index" do
  before(:each) do
    assign(:dang_ky_day_bus, [
      stub_model(DangKyDayBu,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tiet_bat_dau => 2,
        :phong => "Phong"
      ),
      stub_model(DangKyDayBu,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :tiet_bat_dau => 2,
        :phong => "Phong"
      )
    ])
  end

  it "renders a list of dang_ky_day_bus" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Giang Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Phong".to_s, :count => 2
  end
end
