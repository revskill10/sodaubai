require 'spec_helper'

describe "lop_mon_hocs/show" do
  before(:each) do
    @lop_mon_hoc = assign(:lop_mon_hoc, stub_model(LopMonHoc,
      :ma_lop => "Ma Lop",
      :ma_giang_vien => "Ma Giang Vien",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :so_tiet => 2,
      :so_tuan_hoc => 3,
      :phong_hoc => "Phong Hoc"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Giang Vien/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Phong Hoc/)
  end
end
