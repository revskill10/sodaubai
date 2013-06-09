require 'spec_helper'

describe "lich_trinh_giang_days/edit" do
  before(:each) do
    @lich_trinh_giang_day = assign(:lich_trinh_giang_day, stub_model(LichTrinhGiangDay,
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :noi_dung_day => "MyText",
      :so_tiet_day => 1,
      :nhan_xet_buoi_hoc => "MyText",
      :phong => "MyString",
      :xac_nhan_sv => false
    ))
  end

  it "renders the edit lich_trinh_giang_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lich_trinh_giang_day_path(@lich_trinh_giang_day), "post" do
      assert_select "input#lich_trinh_giang_day_ma_lop[name=?]", "lich_trinh_giang_day[ma_lop]"
      assert_select "input#lich_trinh_giang_day_ma_mon_hoc[name=?]", "lich_trinh_giang_day[ma_mon_hoc]"
      assert_select "input#lich_trinh_giang_day_nam_hoc[name=?]", "lich_trinh_giang_day[nam_hoc]"
      assert_select "input#lich_trinh_giang_day_hoc_ky[name=?]", "lich_trinh_giang_day[hoc_ky]"
      assert_select "textarea#lich_trinh_giang_day_noi_dung_day[name=?]", "lich_trinh_giang_day[noi_dung_day]"
      assert_select "input#lich_trinh_giang_day_so_tiet_day[name=?]", "lich_trinh_giang_day[so_tiet_day]"
      assert_select "textarea#lich_trinh_giang_day_nhan_xet_buoi_hoc[name=?]", "lich_trinh_giang_day[nhan_xet_buoi_hoc]"
      assert_select "input#lich_trinh_giang_day_phong[name=?]", "lich_trinh_giang_day[phong]"
      assert_select "input#lich_trinh_giang_day_xac_nhan_sv[name=?]", "lich_trinh_giang_day[xac_nhan_sv]"
    end
  end
end
