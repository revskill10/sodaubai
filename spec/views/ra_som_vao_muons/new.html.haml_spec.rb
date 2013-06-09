require 'spec_helper'

describe "ra_som_vao_muons/new" do
  before(:each) do
    assign(:ra_som_vao_muon, stub_model(RaSomVaoMuon,
      :ma_giang_vien => "MyString",
      :ma_lop => "MyString",
      :ma_mon_hoc => "MyString",
      :nam_hoc => "MyString",
      :hoc_ky => 1,
      :loai => 1,
      :phong => "MyString",
      :tiet => 1
    ).as_new_record)
  end

  it "renders new ra_som_vao_muon form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ra_som_vao_muons_path, "post" do
      assert_select "input#ra_som_vao_muon_ma_giang_vien[name=?]", "ra_som_vao_muon[ma_giang_vien]"
      assert_select "input#ra_som_vao_muon_ma_lop[name=?]", "ra_som_vao_muon[ma_lop]"
      assert_select "input#ra_som_vao_muon_ma_mon_hoc[name=?]", "ra_som_vao_muon[ma_mon_hoc]"
      assert_select "input#ra_som_vao_muon_nam_hoc[name=?]", "ra_som_vao_muon[nam_hoc]"
      assert_select "input#ra_som_vao_muon_hoc_ky[name=?]", "ra_som_vao_muon[hoc_ky]"
      assert_select "input#ra_som_vao_muon_loai[name=?]", "ra_som_vao_muon[loai]"
      assert_select "input#ra_som_vao_muon_phong[name=?]", "ra_som_vao_muon[phong]"
      assert_select "input#ra_som_vao_muon_tiet[name=?]", "ra_som_vao_muon[tiet]"
    end
  end
end
