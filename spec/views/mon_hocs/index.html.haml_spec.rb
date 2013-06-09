require 'spec_helper'

describe "mon_hocs/index" do
  before(:each) do
    assign(:mon_hocs, [
      stub_model(MonHoc,
        :ma_mon_hoc => "Ma Mon Hoc",
        :ten_mon => "Ten Mon"
      ),
      stub_model(MonHoc,
        :ma_mon_hoc => "Ma Mon Hoc",
        :ten_mon => "Ten Mon"
      )
    ])
  end

  it "renders a list of mon_hocs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Mon Hoc".to_s, :count => 2
    assert_select "tr>td", :text => "Ten Mon".to_s, :count => 2
  end
end
