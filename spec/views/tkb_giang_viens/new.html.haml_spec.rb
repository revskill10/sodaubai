require 'spec_helper'

describe "tkb_giang_viens/new" do
  before(:each) do
    assign(:tkb_giang_vien, stub_model(TkbGiangVien,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :phong => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :tuan_hoc_bat_dau => 1,
      :so_tuan => 1,
      :so_tiet => 1,
      :tiet_bat_dau => 1,
      :thu => 1
    ).as_new_record)
  end

  it "renders new tkb_giang_vien form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tkb_giang_viens_path, "post" do
      assert_select "input#tkb_giang_vien_ma_giang_vien[name=?]", "tkb_giang_vien[ma_giang_vien]"
      assert_select "input#tkb_giang_vien_ma_lop[name=?]", "tkb_giang_vien[ma_lop]"
      assert_select "input#tkb_giang_vien_ma_mon_hoc[name=?]", "tkb_giang_vien[ma_mon_hoc]"
      assert_select "input#tkb_giang_vien_phong[name=?]", "tkb_giang_vien[phong]"
      assert_select "input#tkb_giang_vien_nam_hoc[name=?]", "tkb_giang_vien[nam_hoc]"
      assert_select "input#tkb_giang_vien_hoc_ky[name=?]", "tkb_giang_vien[hoc_ky]"
      assert_select "input#tkb_giang_vien_tuan_hoc_bat_dau[name=?]", "tkb_giang_vien[tuan_hoc_bat_dau]"
      assert_select "input#tkb_giang_vien_so_tuan[name=?]", "tkb_giang_vien[so_tuan]"
      assert_select "input#tkb_giang_vien_so_tiet[name=?]", "tkb_giang_vien[so_tiet]"
      assert_select "input#tkb_giang_vien_tiet_bat_dau[name=?]", "tkb_giang_vien[tiet_bat_dau]"
      assert_select "input#tkb_giang_vien_thu[name=?]", "tkb_giang_vien[thu]"
    end
  end
end
