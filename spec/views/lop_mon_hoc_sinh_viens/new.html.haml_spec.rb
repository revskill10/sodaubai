require 'spec_helper'

describe "lop_mon_hoc_sinh_viens/new" do
  before(:each) do
    assign(:lop_mon_hoc_sinh_vien, stub_model(LopMonHocSinhVien,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => ""
    ).as_new_record)
  end

  it "renders new lop_mon_hoc_sinh_vien form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lop_mon_hoc_sinh_viens_path, "post" do
      assert_select "input#lop_mon_hoc_sinh_vien_ma_sinh_vien[name=?]", "lop_mon_hoc_sinh_vien[ma_sinh_vien]"
      assert_select "input#lop_mon_hoc_sinh_vien_ma_lop[name=?]", "lop_mon_hoc_sinh_vien[ma_lop]"
      assert_select "input#lop_mon_hoc_sinh_vien_ma_mon_hoc[name=?]", "lop_mon_hoc_sinh_vien[ma_mon_hoc]"
      assert_select "input#lop_mon_hoc_sinh_vien_nam_hoc[name=?]", "lop_mon_hoc_sinh_vien[nam_hoc]"
      assert_select "input#lop_mon_hoc_sinh_vien_hoc_ky[name=?]", "lop_mon_hoc_sinh_vien[hoc_ky]"
    end
  end
end
