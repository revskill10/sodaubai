require "spec_helper"

describe DangKyDayBusController do
  describe "routing" do

    it "routes to #index" do
      get("/dang_ky_day_bus").should route_to("dang_ky_day_bus#index")
    end

    it "routes to #new" do
      get("/dang_ky_day_bus/new").should route_to("dang_ky_day_bus#new")
    end

    it "routes to #show" do
      get("/dang_ky_day_bus/1").should route_to("dang_ky_day_bus#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dang_ky_day_bus/1/edit").should route_to("dang_ky_day_bus#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dang_ky_day_bus").should route_to("dang_ky_day_bus#create")
    end

    it "routes to #update" do
      put("/dang_ky_day_bus/1").should route_to("dang_ky_day_bus#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dang_ky_day_bus/1").should route_to("dang_ky_day_bus#destroy", :id => "1")
    end

  end
end
