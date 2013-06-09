require 'spec_helper'

describe "diem_chi_tiets/index" do
  before(:each) do
    assign(:diem_chi_tiets, [
      stub_model(DiemChiTiet,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :diem => 2,
        :loai_diem => "Loai Diem",
        :lan => 3
      ),
      stub_model(DiemChiTiet,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ma_lop => "Ma Lop",
        :ma_mon_hoc => "Ma Mon Hoc",
        :nam_hoc => "Nam Hoc",
        :hoc_ky => 1,
        :diem => 2,
        :loai_diem => "Loai Diem",
        :lan => 3
      )
    ])
  end

  it "renders a list of diem_chi_tiets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Nam Hoc".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Loai Diem".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
