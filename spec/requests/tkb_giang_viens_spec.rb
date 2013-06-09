require 'spec_helper'

describe "TkbGiangViens" do
  describe "GET /tkb_giang_viens" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tkb_giang_viens_path
      response.status.should be(200)
    end
  end
end
