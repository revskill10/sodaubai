require 'spec_helper'

describe "tkb_giang_viens/show" do
  before(:each) do
    @tkb_giang_vien = assign(:tkb_giang_vien, stub_model(TkbGiangVien,
      :ma_giang_vien => "Ma Giang Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :phong => "Phong",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :tuan_hoc_bat_dau => 2,
      :so_tuan => 3,
      :so_tiet => 4,
      :tiet_bat_dau => 5,
      :thu => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Giang Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Phong/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
