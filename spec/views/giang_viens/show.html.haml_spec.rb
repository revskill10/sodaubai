require 'spec_helper'

describe "giang_viens/show" do
  before(:each) do
    @giang_vien = assign(:giang_vien, stub_model(GiangVien,
      :ho_ten => "Ho Ten",
      :hoc_vi => "Hoc Vi",
      :hoc_ham => "Hoc Ham",
      :ma_don_vi => "Ma Don Vi",
      :ma_loai => "Ma Loai",
      :ma_giang_vien => "Ma Giang Vien"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ho Ten/)
    rendered.should match(/Hoc Vi/)
    rendered.should match(/Hoc Ham/)
    rendered.should match(/Ma Don Vi/)
    rendered.should match(/Ma Loai/)
    rendered.should match(/Ma Giang Vien/)
  end
end
