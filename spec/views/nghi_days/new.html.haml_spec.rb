require 'spec_helper'

describe "nghi_days/new" do
  before(:each) do
    assign(:nghi_day, stub_model(NghiDay,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :phong => "MyString"
    ).as_new_record)
  end

  it "renders new nghi_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nghi_days_path, "post" do
      assert_select "input#nghi_day_ma_giang_vien[name=?]", "nghi_day[ma_giang_vien]"
      assert_select "input#nghi_day_ma_lop[name=?]", "nghi_day[ma_lop]"
      assert_select "input#nghi_day_ma_mon_hoc[name=?]", "nghi_day[ma_mon_hoc]"
      assert_select "input#nghi_day_nam_hoc[name=?]", "nghi_day[nam_hoc]"
      assert_select "input#nghi_day_hoc_ky[name=?]", "nghi_day[hoc_ky]"
      assert_select "input#nghi_day_phong[name=?]", "nghi_day[phong]"
    end
  end
end
