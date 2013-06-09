require 'spec_helper'

describe "dang_ky_day_bus/new" do
  before(:each) do
    assign(:dang_ky_day_bu, stub_model(DangKyDayBu,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :tiet_bat_dau => 1,
      :phong => "MyString"
    ).as_new_record)
  end

  it "renders new dang_ky_day_bu form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dang_ky_day_bus_path, "post" do
      assert_select "input#dang_ky_day_bu_ma_giang_vien[name=?]", "dang_ky_day_bu[ma_giang_vien]"
      assert_select "input#dang_ky_day_bu_ma_lop[name=?]", "dang_ky_day_bu[ma_lop]"
      assert_select "input#dang_ky_day_bu_ma_mon_hoc[name=?]", "dang_ky_day_bu[ma_mon_hoc]"
      assert_select "input#dang_ky_day_bu_nam_hoc[name=?]", "dang_ky_day_bu[nam_hoc]"
      assert_select "input#dang_ky_day_bu_hoc_ky[name=?]", "dang_ky_day_bu[hoc_ky]"
      assert_select "input#dang_ky_day_bu_tiet_bat_dau[name=?]", "dang_ky_day_bu[tiet_bat_dau]"
      assert_select "input#dang_ky_day_bu_phong[name=?]", "dang_ky_day_bu[phong]"
    end
  end
end
