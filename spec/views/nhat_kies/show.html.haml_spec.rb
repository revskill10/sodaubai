require 'spec_helper'

describe "nhat_kies/show" do
  before(:each) do
    @nhat_ky = assign(:nhat_ky, stub_model(NhatKy,
      :ma_nguoi_dung => "Ma Nguoi Dung",
      :ma_lop => "Ma Lop",
      :noi_dung => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Nguoi Dung/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/MyText/)
  end
end
