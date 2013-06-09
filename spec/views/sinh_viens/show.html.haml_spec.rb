require 'spec_helper'

describe "sinh_viens/show" do
  before(:each) do
    @sinh_vien = assign(:sinh_vien, stub_model(SinhVien,
      :ma_sinh_vien => "Ma Sinh Vien",
      :ho_dem => "Ho Dem",
      :ten => "Ten",
      :gioi_tinh => false,
      :lop_hc => "Lop Hc",
      :ma_khoa_hoc => "Ma Khoa Hoc",
      :ma_he_dao_tao => "Ma He Dao Tao",
      :ma_nganh => "Ma Nganh"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ma Sinh Vien/)
    rendered.should match(/Ho Dem/)
    rendered.should match(/Ten/)
    rendered.should match(/false/)
    rendered.should match(/Lop Hc/)
    rendered.should match(/Ma Khoa Hoc/)
    rendered.should match(/Ma He Dao Tao/)
    rendered.should match(/Ma Nganh/)
  end
end
