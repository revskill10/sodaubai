require "spec_helper"

describe LichTrinhGiangDaysController do
  describe "routing" do

    it "routes to #index" do
      get("/lich_trinh_giang_days").should route_to("lich_trinh_giang_days#index")
    end

    it "routes to #new" do
      get("/lich_trinh_giang_days/new").should route_to("lich_trinh_giang_days#new")
    end

    it "routes to #show" do
      get("/lich_trinh_giang_days/1").should route_to("lich_trinh_giang_days#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lich_trinh_giang_days/1/edit").should route_to("lich_trinh_giang_days#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lich_trinh_giang_days").should route_to("lich_trinh_giang_days#create")
    end

    it "routes to #update" do
      put("/lich_trinh_giang_days/1").should route_to("lich_trinh_giang_days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lich_trinh_giang_days/1").should route_to("lich_trinh_giang_days#destroy", :id => "1")
    end

  end
end
