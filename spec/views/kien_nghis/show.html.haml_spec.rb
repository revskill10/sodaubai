require 'spec_helper'

describe "kien_nghis/show" do
  before(:each) do
    @kien_nghi = assign(:kien_nghi, stub_model(KienNghi,
      :ma_sinh_vien => "Ma Sinh Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :noi_dung => "MyText",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :nhom_id => 2,
      :trang_thai => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Sinh Vien/)
    rendered.should match(/Ma Lop/)
    rendered.should match(/Ma Mon Hoc/)
    rendered.should match(/MyText/)
    rendered.should match(/Nam Hoc/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
