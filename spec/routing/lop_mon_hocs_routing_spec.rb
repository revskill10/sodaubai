require "spec_helper"

describe LopMonHocsController do
  describe "routing" do

    it "routes to #index" do
      get("/lop_mon_hocs").should route_to("lop_mon_hocs#index")
    end

    it "routes to #new" do
      get("/lop_mon_hocs/new").should route_to("lop_mon_hocs#new")
    end

    it "routes to #show" do
      get("/lop_mon_hocs/1").should route_to("lop_mon_hocs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lop_mon_hocs/1/edit").should route_to("lop_mon_hocs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lop_mon_hocs").should route_to("lop_mon_hocs#create")
    end

    it "routes to #update" do
      put("/lop_mon_hocs/1").should route_to("lop_mon_hocs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lop_mon_hocs/1").should route_to("lop_mon_hocs#destroy", :id => "1")
    end

  end
end
