require 'spec_helper'

describe "lop_mon_hoc_sinh_viens/index" do
  before(:each) do
    assign(:lop_mon_hoc_sinh_viens, [
      stub_model(LopMonHocSinhVien,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => ""
      ),
      stub_model(LopMonHocSinhVien,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => ""
      )
    ])
  end

  it "renders a list of lop_mon_hoc_sinh_viens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
