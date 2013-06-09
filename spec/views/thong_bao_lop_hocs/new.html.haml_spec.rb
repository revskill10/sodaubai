require 'spec_helper'

describe "thong_bao_lop_hocs/new" do
  before(:each) do
    assign(:thong_bao_lop_hoc, stub_model(ThongBaoLopHoc,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :noi_dung => "MyText",
      :nam_hoc => "MyString",
      :hoc_ky => 1
    ).as_new_record)
  end

  it "renders new thong_bao_lop_hoc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", thong_bao_lop_hocs_path, "post" do
      assert_select "input#thong_bao_lop_hoc_ma_giang_vien[name=?]", "thong_bao_lop_hoc[ma_giang_vien]"
      assert_select "input#thong_bao_lop_hoc_ma_lop[name=?]", "thong_bao_lop_hoc[ma_lop]"
      assert_select "input#thong_bao_lop_hoc_ma_mon_hoc[name=?]", "thong_bao_lop_hoc[ma_mon_hoc]"
      assert_select "textarea#thong_bao_lop_hoc_noi_dung[name=?]", "thong_bao_lop_hoc[noi_dung]"
      assert_select "input#thong_bao_lop_hoc_nam_hoc[name=?]", "thong_bao_lop_hoc[nam_hoc]"
      assert_select "input#thong_bao_lop_hoc_hoc_ky[name=?]", "thong_bao_lop_hoc[hoc_ky]"
    end
  end
end
