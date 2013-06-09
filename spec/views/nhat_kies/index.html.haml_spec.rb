require 'spec_helper'

describe "nhat_kies/index" do
  before(:each) do
    assign(:nhat_kies, [
      stub_model(NhatKy,
        :ma_nguoi_dung => "Ma Nguoi Dung",
        :ma_lop => "Ma Lop",
        :noi_dung => "MyText"
      ),
      stub_model(NhatKy,
        :ma_nguoi_dung => "Ma Nguoi Dung",
        :ma_lop => "Ma Lop",
        :noi_dung => "MyText"
      )
    ])
  end

  it "renders a list of nhat_kies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ma Nguoi Dung".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Lop".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
