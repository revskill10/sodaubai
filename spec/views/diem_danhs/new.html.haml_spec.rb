require 'spec_helper'

describe "diem_danhs/new" do
  before(:each) do
    assign(:diem_danh, stub_model(DiemDanh,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :so_tiet_vang => 1
    ).as_new_record)
  end

  it "renders new diem_danh form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", diem_danhs_path, "post" do
      assert_select "input#diem_danh_ma_sinh_vien[name=?]", "diem_danh[ma_sinh_vien]"
      assert_select "input#diem_danh_ma_lop[name=?]", "diem_danh[ma_lop]"
      assert_select "input#diem_danh_ma_mon_hoc[name=?]", "diem_danh[ma_mon_hoc]"
      assert_select "input#diem_danh_nam_hoc[name=?]", "diem_danh[nam_hoc]"
      assert_select "input#diem_danh_hoc_ky[name=?]", "diem_danh[hoc_ky]"
      assert_select "input#diem_danh_so_tiet_vang[name=?]", "diem_danh[so_tiet_vang]"
    end
  end
end
