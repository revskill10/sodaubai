require 'spec_helper'

describe "ThongBaoLopHocs" do
  describe "GET /thong_bao_lop_hocs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get thong_bao_lop_hocs_path
      response.status.should be(200)
    end
  end
end
