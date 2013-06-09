require 'spec_helper'

describe "thong_bao_lop_hocs/show" do
  before(:each) do
    @thong_bao_lop_hoc = assign(:thong_bao_lop_hoc, stub_model(ThongBaoLopHoc,
      :ma_giang_vien => "Ma Giang Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :noi_dung => "MyText",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Giang Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/MyText/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
  end
end
