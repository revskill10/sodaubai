require 'spec_helper'

describe "DangKyDayBus" do
  describe "GET /dang_ky_day_bus" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dang_ky_day_bus_path
      response.status.should be(200)
    end
  end
end
