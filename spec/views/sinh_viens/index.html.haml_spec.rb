require 'spec_helper'

describe "sinh_viens/index" do
  before(:each) do
    assign(:sinh_viens, [
      stub_model(SinhVien,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ho_dem => "Ho Dem",
        :ten => "Ten",
        :gioi_tinh => false,
        :lop_hc => "Lop Hc",
        :ma_khoa_hoc => "Ma Khoa Hoc",
        :ma_he_dao_tao => "Ma He Dao Tao",
        :ma_nganh => "Ma Nganh"
      ),
      stub_model(SinhVien,
        :ma_sinh_vien => "Ma Sinh Vien",
        :ho_dem => "Ho Dem",
        :ten => "Ten",
        :gioi_tinh => false,
        :lop_hc => "Lop Hc",
        :ma_khoa_hoc => "Ma Khoa Hoc",
        :ma_he_dao_tao => "Ma He Dao Tao",
        :ma_nganh => "Ma Nganh"
      )
    ])
  end

  it "renders a list of sinh_viens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Sinh Vien".to_s, :count => 2
    assert_select "tr>td", :text => "Ho Dem".to_s, :count => 2
    assert_select "tr>td", :text => "Ten".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Lop Hc".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Khoa Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Ma He Dao Tao".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Nganh".to_s, :count => 2
  end
end
