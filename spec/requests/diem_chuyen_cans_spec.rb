require 'spec_helper'

describe "DiemChuyenCans" do
  describe "GET /diem_chuyen_cans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get diem_chuyen_cans_path
      response.status.should be(200)
    end
  end
end
