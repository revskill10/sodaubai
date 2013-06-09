require 'spec_helper'

describe "lop_mon_hoc_sinh_viens/edit" do
  before(:each) do
    @lop_mon_hoc_sinh_vien = assign(:lop_mon_hoc_sinh_vien, stub_model(LopMonHocSinhVien,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => ""
    ))
  end

  it "renders the edit lop_mon_hoc_sinh_vien form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lop_mon_hoc_sinh_vien_path(@lop_mon_hoc_sinh_vien), "post" do
      assert_select "input#lop_mon_hoc_sinh_vien_ma_sinh_vien[name=?]", "lop_mon_hoc_sinh_vien[ma_sinh_vien]"
      assert_select "input#lop_mon_hoc_sinh_vien_ma_lop[name=?]", "lop_mon_hoc_sinh_vien[ma_lop]"
      assert_select "input#lop_mon_hoc_sinh_vien_ma_mon_hoc[name=?]", "lop_mon_hoc_sinh_vien[ma_mon_hoc]"
      assert_select "input#lop_mon_hoc_sinh_vien_nam_hoc[name=?]", "lop_mon_hoc_sinh_vien[nam_hoc]"
      assert_select "input#lop_mon_hoc_sinh_vien_hoc_ky[name=?]", "lop_mon_hoc_sinh_vien[hoc_ky]"
    end
  end
end
