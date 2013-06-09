require 'spec_helper'

describe "lop_mon_hocs/edit" do
  before(:each) do
    @lop_mon_hoc = assign(:lop_mon_hoc, stub_model(LopMonHoc,
      :ma_lop => "MyString",
      :ma_giang_vien => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :so_tiet => 1,
      :so_tuan_hoc => 1,
      :phong_hoc => "MyString"
    ))
  end

  it "renders the edit lop_mon_hoc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lop_mon_hoc_path(@lop_mon_hoc), "post" do
      assert_select "input#lop_mon_hoc_ma_lop[name=?]", "lop_mon_hoc[ma_lop]"
      assert_select "input#lop_mon_hoc_ma_giang_vien[name=?]", "lop_mon_hoc[ma_giang_vien]"
      assert_select "input#lop_mon_hoc_ma_mon_hoc[name=?]", "lop_mon_hoc[ma_mon_hoc]"
      assert_select "input#lop_mon_hoc_nam_hoc[name=?]", "lop_mon_hoc[nam_hoc]"
      assert_select "input#lop_mon_hoc_hoc_ky[name=?]", "lop_mon_hoc[hoc_ky]"
      assert_select "input#lop_mon_hoc_so_tiet[name=?]", "lop_mon_hoc[so_tiet]"
      assert_select "input#lop_mon_hoc_so_tuan_hoc[name=?]", "lop_mon_hoc[so_tuan_hoc]"
      assert_select "input#lop_mon_hoc_phong_hoc[name=?]", "lop_mon_hoc[phong_hoc]"
    end
  end
end
