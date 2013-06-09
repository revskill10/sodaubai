require 'spec_helper'

describe "mon_hocs/show" do
  before(:each) do
    @mon_hoc = assign(:mon_hoc, stub_model(MonHoc,
      :ma_mon_hoc => "Ma Mon Hoc",
      :ten_mon => "Ten Mon"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Ten Mon/)
  end
end
