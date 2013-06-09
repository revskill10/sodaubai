require 'spec_helper'

describe "lop_mon_hoc_sinh_viens/show" do
  before(:each) do
    @lop_mon_hoc_sinh_vien = assign(:lop_mon_hoc_sinh_vien, stub_model(LopMonHocSinhVien,
      :ma_sinh_vien => "Ma Sinh Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Sinh Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(//)
  end
end
