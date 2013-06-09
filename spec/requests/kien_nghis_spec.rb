require 'spec_helper'

describe "KienNghis" do
  describe "GET /kien_nghis" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get kien_nghis_path
      response.status.should be(200)
    end
  end
end
