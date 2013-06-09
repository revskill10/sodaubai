require 'spec_helper'

describe "day_thays/show" do
  before(:each) do
    @day_thay = assign(:day_thay, stub_model(DayThay,
      :ma_giang_vien => "Ma Giang Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :phong => "Phong"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Giang Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/Phong/)
  end
end
