require 'spec_helper'

describe "kien_nghis/new" do
  before(:each) do
    assign(:kien_nghi, stub_model(KienNghi,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :noi_dung => "MyText",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :nhom_id => 1,
      :trang_thai => false
    ).as_new_record)
  end

  it "renders new kien_nghi form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", kien_nghis_path, "post" do
      assert_select "input#kien_nghi_ma_sinh_vien[name=?]", "kien_nghi[ma_sinh_vien]"
      assert_select "input#kien_nghi_ma_lop[name=?]", "kien_nghi[ma_lop]"
      assert_select "input#kien_nghi_ma_mon_hoc[name=?]", "kien_nghi[ma_mon_hoc]"
      assert_select "textarea#kien_nghi_noi_dung[name=?]", "kien_nghi[noi_dung]"
      assert_select "input#kien_nghi_nam_hoc[name=?]", "kien_nghi[nam_hoc]"
      assert_select "input#kien_nghi_hoc_ky[name=?]", "kien_nghi[hoc_ky]"
      assert_select "input#kien_nghi_nhom_id[name=?]", "kien_nghi[nhom_id]"
      assert_select "input#kien_nghi_trang_thai[name=?]", "kien_nghi[trang_thai]"
    end
  end
end
