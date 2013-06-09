require 'spec_helper'

describe "ra_som_vao_muons/show" do
  before(:each) do
    @ra_som_vao_muon = assign(:ra_som_vao_muon, stub_model(RaSomVaoMuon,
      :ma_giang_vien => "Ma Giang Vien",
      :ma_lop => "Ma Lop",
      :ma_mon_hoc => "Ma Mon Hoc",
      :nam_hoc => "Nam Hoc",
      :hoc_ky => 1,
      :loai => 2,
      :phong => "Phong",
      :tiet => 3
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
    rendered.should match(/2/)
    rendered.should match(/Phong/)
    rendered.should match(/3/)
  end
end
