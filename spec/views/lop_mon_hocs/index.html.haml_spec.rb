require 'spec_helper'

describe "lop_mon_hocs/index" do
  before(:each) do
    assign(:lop_mon_hocs, [
      stub_model(LopMonHoc,
        :ma_lop => "Ma Lop",
        :ma_giang_vien => "Ma Giang Vien",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :so_tiet => 2,
        :so_tuan_hoc => 3,
        :phong_hoc => "Phong Hoc"
      ),
      stub_model(LopMonHoc,
        :ma_lop => "Ma Lop",
        :ma_giang_vien => "Ma Giang Vien",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :so_tiet => 2,
        :so_tuan_hoc => 3,
        :phong_hoc => "Phong Hoc"
      )
    ])
  end

  it "renders a list of lop_mon_hocs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Giang Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Phong Hoc".to_s, :count => 2
  end
end
