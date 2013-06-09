require 'spec_helper'

describe "mon_hocs/edit" do
  before(:each) do
    @mon_hoc = assign(:mon_hoc, stub_model(MonHoc,
      :ma_mon_hoc => "MyString",
      :ten_mon => "MyString"
    ))
  end

  it "renders the edit mon_hoc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mon_hoc_path(@mon_hoc), "post" do
      assert_select "input#mon_hoc_ma_mon_hoc[name=?]", "mon_hoc[ma_mon_hoc]"
      assert_select "input#mon_hoc_ten_mon[name=?]", "mon_hoc[ten_mon]"
    end
  end
end
