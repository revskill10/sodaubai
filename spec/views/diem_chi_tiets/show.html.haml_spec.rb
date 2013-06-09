require 'spec_helper'

describe "diem_chi_tiets/show" do
  before(:each) do
    @diem_chi_tiet = assign(:diem_chi_tiet, stub_model(DiemChiTiet,
      :ma_sinh_vien => "Ma Sinh Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :diem => 2,
      :loai_diem => "Loai Diem",
      :lan => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Sinh Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Loai Diem/)
    rendered.should match(/3/)
  end
end
