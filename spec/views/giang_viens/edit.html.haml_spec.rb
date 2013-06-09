require 'spec_helper'

describe "giang_viens/edit" do
  before(:each) do
    @giang_vien = assign(:giang_vien, stub_model(GiangVien,
      :ho_ten => "MyString",
      :hoc_vi => "MyString",
      :hoc_ham => "MyString",
      :ma_don_vi => "MyString",
      :ma_loai => "MyString",
      :ma_giang_vien => "MyString"
    ))
  end

  it "renders the edit giang_vien form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", giang_vien_path(@giang_vien), "post" do
      assert_select "input#giang_vien_ho_ten[name=?]", "giang_vien[ho_ten]"
      assert_select "input#giang_vien_hoc_vi[name=?]", "giang_vien[hoc_vi]"
      assert_select "input#giang_vien_hoc_ham[name=?]", "giang_vien[hoc_ham]"
      assert_select "input#giang_vien_ma_don_vi[name=?]", "giang_vien[ma_don_vi]"
      assert_select "input#giang_vien_ma_loai[name=?]", "giang_vien[ma_loai]"
      assert_select "input#giang_vien_ma_giang_vien[name=?]", "giang_vien[ma_giang_vien]"
    end
  end
end
