require 'spec_helper'

describe "DiemChiTiets" do
  describe "GET /diem_chi_tiets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get diem_chi_tiets_path
      response.status.should be(200)
    end
  end
end
