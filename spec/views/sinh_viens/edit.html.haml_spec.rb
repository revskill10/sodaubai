require 'spec_helper'

describe "sinh_viens/edit" do
  before(:each) do
    @sinh_vien = assign(:sinh_vien, stub_model(SinhVien,
      :ma_sinh_vien => "MyString",
      :ho_dem => "MyString",
      :ten => "MyString",
      :gioi_tinh => false,
      :lop_hc => "MyString",
      :ma_khoa_hoc => "MyString",
      :ma_he_dao_tao => "MyString",
      :ma_nganh => "MyString"
    ))
  end

  it "renders the edit sinh_vien form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sinh_vien_path(@sinh_vien), "post" do
      assert_select "input#sinh_vien_ma_sinh_vien[name=?]", "sinh_vien[ma_sinh_vien]"
      assert_select "input#sinh_vien_ho_dem[name=?]", "sinh_vien[ho_dem]"
      assert_select "input#sinh_vien_ten[name=?]", "sinh_vien[ten]"
      assert_select "input#sinh_vien_gioi_tinh[name=?]", "sinh_vien[gioi_tinh]"
      assert_select "input#sinh_vien_lop_hc[name=?]", "sinh_vien[lop_hc]"
      assert_select "input#sinh_vien_ma_khoa_hoc[name=?]", "sinh_vien[ma_khoa_hoc]"
      assert_select "input#sinh_vien_ma_he_dao_tao[name=?]", "sinh_vien[ma_he_dao_tao]"
      assert_select "input#sinh_vien_ma_nganh[name=?]", "sinh_vien[ma_nganh]"
    end
  end
end
