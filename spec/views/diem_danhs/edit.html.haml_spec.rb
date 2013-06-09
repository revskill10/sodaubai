require 'spec_helper'

describe "diem_danhs/edit" do
  before(:each) do
    @diem_danh = assign(:diem_danh, stub_model(DiemDanh,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :so_tiet_vang => 1
    ))
  end

  it "renders the edit diem_danh form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", diem_danh_path(@diem_danh), "post" do
      assert_select "input#diem_danh_ma_sinh_vien[name=?]", "diem_danh[ma_sinh_vien]"
      assert_select "input#diem_danh_ma_lop[name=?]", "diem_danh[ma_lop]"
      assert_select "input#diem_danh_ma_mon_hoc[name=?]", "diem_danh[ma_mon_hoc]"
      assert_select "input#diem_danh_nam_hoc[name=?]", "diem_danh[nam_hoc]"
      assert_select "input#diem_danh_hoc_ky[name=?]", "diem_danh[hoc_ky]"
      assert_select "input#diem_danh_so_tiet_vang[name=?]", "diem_danh[so_tiet_vang]"
    end
  end
end
