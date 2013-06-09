require 'spec_helper'

describe "tai_lieu_mon_hocs/edit" do
  before(:each) do
    @tai_lieu_mon_hoc = assign(:tai_lieu_mon_hoc, stub_model(TaiLieuMonHoc,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :noi_dung => "MyText",
      :nam_hoc => "MyString",
      :hoc_ky => 1
    ))
  end

  it "renders the edit tai_lieu_mon_hoc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tai_lieu_mon_hoc_path(@tai_lieu_mon_hoc), "post" do
      assert_select "input#tai_lieu_mon_hoc_ma_giang_vien[name=?]", "tai_lieu_mon_hoc[ma_giang_vien]"
      assert_select "input#tai_lieu_mon_hoc_ma_lop[name=?]", "tai_lieu_mon_hoc[ma_lop]"
      assert_select "input#tai_lieu_mon_hoc_ma_mon_hoc[name=?]", "tai_lieu_mon_hoc[ma_mon_hoc]"
      assert_select "textarea#tai_lieu_mon_hoc_noi_dung[name=?]", "tai_lieu_mon_hoc[noi_dung]"
      assert_select "input#tai_lieu_mon_hoc_nam_hoc[name=?]", "tai_lieu_mon_hoc[nam_hoc]"
      assert_select "input#tai_lieu_mon_hoc_hoc_ky[name=?]", "tai_lieu_mon_hoc[hoc_ky]"
    end
  end
end
