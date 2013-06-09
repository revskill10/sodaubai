require 'spec_helper'

describe "diem_chuyen_cans/edit" do
  before(:each) do
    @diem_chuyen_can = assign(:diem_chuyen_can, stub_model(DiemChuyenCan,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :tong_so_tiet => 1,
      :tong_so_tiet_vang => 1,
      :diem => 1
    ))
  end

  it "renders the edit diem_chuyen_can form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", diem_chuyen_can_path(@diem_chuyen_can), "post" do
      assert_select "input#diem_chuyen_can_ma_sinh_vien[name=?]", "diem_chuyen_can[ma_sinh_vien]"
      assert_select "input#diem_chuyen_can_ma_lop[name=?]", "diem_chuyen_can[ma_lop]"
      assert_select "input#diem_chuyen_can_ma_mon_hoc[name=?]", "diem_chuyen_can[ma_mon_hoc]"
      assert_select "input#diem_chuyen_can_nam_hoc[name=?]", "diem_chuyen_can[nam_hoc]"
      assert_select "input#diem_chuyen_can_hoc_ky[name=?]", "diem_chuyen_can[hoc_ky]"
      assert_select "input#diem_chuyen_can_tong_so_tiet[name=?]", "diem_chuyen_can[tong_so_tiet]"
      assert_select "input#diem_chuyen_can_tong_so_tiet_vang[name=?]", "diem_chuyen_can[tong_so_tiet_vang]"
      assert_select "input#diem_chuyen_can_diem[name=?]", "diem_chuyen_can[diem]"
    end
  end
end
