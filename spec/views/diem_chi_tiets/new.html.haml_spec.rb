require 'spec_helper'

describe "diem_chi_tiets/new" do
  before(:each) do
    assign(:diem_chi_tiet, stub_model(DiemChiTiet,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :diem => 1,
      :loai_diem => "MyString",
      :lan => 1
    ).as_new_record)
  end

  it "renders new diem_chi_tiet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", diem_chi_tiets_path, "post" do
      assert_select "input#diem_chi_tiet_ma_sinh_vien[name=?]", "diem_chi_tiet[ma_sinh_vien]"
      assert_select "input#diem_chi_tiet_ma_lop[name=?]", "diem_chi_tiet[ma_lop]"
      assert_select "input#diem_chi_tiet_ma_mon_hoc[name=?]", "diem_chi_tiet[ma_mon_hoc]"
      assert_select "input#diem_chi_tiet_nam_hoc[name=?]", "diem_chi_tiet[nam_hoc]"
      assert_select "input#diem_chi_tiet_hoc_ky[name=?]", "diem_chi_tiet[hoc_ky]"
      assert_select "input#diem_chi_tiet_diem[name=?]", "diem_chi_tiet[diem]"
      assert_select "input#diem_chi_tiet_loai_diem[name=?]", "diem_chi_tiet[loai_diem]"
      assert_select "input#diem_chi_tiet_lan[name=?]", "diem_chi_tiet[lan]"
    end
  end
end
