require 'spec_helper'

describe "giang_viens/index" do
  before(:each) do
    assign(:giang_viens, [
      stub_model(GiangVien,
        :ho_ten => "Ho Ten",
        :hoc_vi => "Hoc Vi",
        :hoc_ham => "Hoc Ham",
        :ma_don_vi => "Ma Don Vi",
        :ma_loai => "Ma Loai",
        :ma_giang_vien => "Ma Giang Vien"
      ),
      stub_model(GiangVien,
        :ho_ten => "Ho Ten",
        :hoc_vi => "Hoc Vi",
        :hoc_ham => "Hoc Ham",
        :ma_don_vi => "Ma Don Vi",
        :ma_loai => "Ma Loai",
        :ma_giang_vien => "Ma Giang Vien"
      )
    ])
  end

  it "renders a list of giang_viens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ho Ten".to_s, :count => 2
    assert_select "tr>td", :text => "Hoc Vi".to_s, :count => 2
    assert_select "tr>td", :text => "Hoc Ham".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Don Vi".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Loai".to_s, :count => 2
    assert_select "tr>td", :text => "Ma Giang Vien".to_s, :count => 2
  end
end
