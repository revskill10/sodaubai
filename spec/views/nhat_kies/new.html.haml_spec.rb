require 'spec_helper'

describe "nhat_kies/new" do
  before(:each) do
    assign(:nhat_ky, stub_model(NhatKy,
      :ma_nguoi_dung => "MyString",
      :ma_lop => "MyString",
      :noi_dung => "MyText"
    ).as_new_record)
  end

  it "renders new nhat_ky form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nhat_kies_path, "post" do
      assert_select "input#nhat_ky_ma_nguoi_dung[name=?]", "nhat_ky[ma_nguoi_dung]"
      assert_select "input#nhat_ky_ma_lop[name=?]", "nhat_ky[ma_lop]"
      assert_select "textarea#nhat_ky_noi_dung[name=?]", "nhat_ky[noi_dung]"
    end
  end
end
