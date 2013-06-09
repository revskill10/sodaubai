require "spec_helper"

describe NghiDaysController do
  describe "routing" do

    it "routes to #index" do
      get("/nghi_days").should route_to("nghi_days#index")
    end

    it "routes to #new" do
      get("/nghi_days/new").should route_to("nghi_days#new")
    end

    it "routes to #show" do
      get("/nghi_days/1").should route_to("nghi_days#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nghi_days/1/edit").should route_to("nghi_days#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nghi_days").should route_to("nghi_days#create")
    end

    it "routes to #update" do
      put("/nghi_days/1").should route_to("nghi_days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nghi_days/1").should route_to("nghi_days#destroy", :id => "1")
    end

  end
end
