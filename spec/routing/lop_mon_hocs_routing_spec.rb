require "spec_helper"

describe LopMonHocsController do
  describe "routing" do

    
    it "routes to #show" do
      get("/lop_mon_hocs/1").should route_to("lop_mon_hocs#show", :id => "1")
    end
   

  end
end
