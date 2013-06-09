require 'spec_helper'

describe "day_thays/index" do
  before(:each) do
    assign(:day_thays, [
      stub_model(DayThay,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :phong => "Phong"
      ),
      stub_model(DayThay,
        :ma_giang_vien => "Ma Giang Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :phong => "Phong"
      )
    ])
  end

  it "renders a list of day_thays" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Giang Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Phong".to_s, :count => 2
  end
end
