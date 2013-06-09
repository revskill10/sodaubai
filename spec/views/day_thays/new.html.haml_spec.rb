require 'spec_helper'

describe "day_thays/new" do
  before(:each) do
    assign(:day_thay, stub_model(DayThay,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :phong => "MyString"
    ).as_new_record)
  end

  it "renders new day_thay form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", day_thays_path, "post" do
      assert_select "input#day_thay_ma_giang_vien[name=?]", "day_thay[ma_giang_vien]"
      assert_select "input#day_thay_ma_lop[name=?]", "day_thay[ma_lop]"
      assert_select "input#day_thay_ma_mon_hoc[name=?]", "day_thay[ma_mon_hoc]"
      assert_select "input#day_thay_nam_hoc[name=?]", "day_thay[nam_hoc]"
      assert_select "input#day_thay_hoc_ky[name=?]", "day_thay[hoc_ky]"
      assert_select "input#day_thay_phong[name=?]", "day_thay[phong]"
    end
  end
end
