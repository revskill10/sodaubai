require 'spec_helper'

describe "kien_nghis/index" do
  before(:each) do
    assign(:kien_nghis, [
      stub_model(KienNghi,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :noi_dung => "MyText",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :nhom_id => 2,
        :trang_thai => false
      ),
      stub_model(KienNghi,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :noi_dung => "MyText",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :nhom_id => 2,
        :trang_thai => false
      )
    ])
  end

  it "renders a list of kien_nghis" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
