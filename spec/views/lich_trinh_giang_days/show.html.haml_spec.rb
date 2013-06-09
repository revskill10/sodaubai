require 'spec_helper'

describe "lich_trinh_giang_days/show" do
  before(:each) do
    @lich_trinh_giang_day = assign(:lich_trinh_giang_day, stub_model(LichTrinhGiangDay,
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :noi_dung_day => "MyText",
      :so_tiet_day => 2,
      :nhan_xet_buoi_hoc => "MyText",
      :phong => "Phong",
      :xac_nhan_sv => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/Phong/)
    rendered.should match(/false/)
  end
end
