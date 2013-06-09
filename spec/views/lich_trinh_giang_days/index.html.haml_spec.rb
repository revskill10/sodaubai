require 'spec_helper'

describe "lich_trinh_giang_days/index" do
  before(:each) do
    assign(:lich_trinh_giang_days, [
      stub_model(LichTrinhGiangDay,
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :noi_dung_day => "MyText",
        :so_tiet_day => 2,
        :nhan_xet_buoi_hoc => "MyText",
        :phong => "Phong",
        :xac_nhan_sv => false
      ),
      stub_model(LichTrinhGiangDay,
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :noi_dung_day => "MyText",
        :so_tiet_day => 2,
        :nhan_xet_buoi_hoc => "MyText",
        :phong => "Phong",
        :xac_nhan_sv => false
      )
    ])
  end

  it "renders a list of lich_trinh_giang_days" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Phong".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
