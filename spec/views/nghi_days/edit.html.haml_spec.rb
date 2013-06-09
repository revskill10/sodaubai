require 'spec_helper'

describe "nghi_days/edit" do
  before(:each) do
    @nghi_day = assign(:nghi_day, stub_model(NghiDay,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :phong => "MyString"
    ))
  end

  it "renders the edit nghi_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nghi_day_path(@nghi_day), "post" do
      assert_select "input#nghi_day_ma_giang_vien[name=?]", "nghi_day[ma_giang_vien]"
      assert_select "input#nghi_day_ma_lop[name=?]", "nghi_day[ma_lop]"
      assert_select "input#nghi_day_ma_mon_hoc[name=?]", "nghi_day[ma_mon_hoc]"
      assert_select "input#nghi_day_nam_hoc[name=?]", "nghi_day[nam_hoc]"
      assert_select "input#nghi_day_hoc_ky[name=?]", "nghi_day[hoc_ky]"
      assert_select "input#nghi_day_phong[name=?]", "nghi_day[phong]"
    end
  end
end
