require 'spec_helper'

describe "SinhViens" do
  describe "GET /sinh_viens" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sinh_viens_path
      response.status.should be(200)
    end
  end
end
