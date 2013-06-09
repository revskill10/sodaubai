require 'spec_helper'

describe "can_bo_lops/new" do
  before(:each) do
    assign(:can_bo_lop, stub_model(CanBoLop,
      :ma_sinh_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1
    ).as_new_record)
  end

  it "renders new can_bo_lop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", can_bo_lops_path, "post" do
      assert_select "input#can_bo_lop_ma_sinh_vien[name=?]", "can_bo_lop[ma_sinh_vien]"
      assert_select "input#can_bo_lop_ma_lop[name=?]", "can_bo_lop[ma_lop]"
      assert_select "input#can_bo_lop_ma_mon_hoc[name=?]", "can_bo_lop[ma_mon_hoc]"
      assert_select "input#can_bo_lop_nam_hoc[name=?]", "can_bo_lop[nam_hoc]"
      assert_select "input#can_bo_lop_hoc_ky[name=?]", "can_bo_lop[hoc_ky]"
    end
  end
end
