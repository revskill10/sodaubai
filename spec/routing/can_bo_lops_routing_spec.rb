require "spec_helper"

describe CanBoLopsController do
  describe "routing" do

    it "routes to #index" do
      get("/can_bo_lops").should route_to("can_bo_lops#index")
    end

    it "routes to #new" do
      get("/can_bo_lops/new").should route_to("can_bo_lops#new")
    end

    it "routes to #show" do
      get("/can_bo_lops/1").should route_to("can_bo_lops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/can_bo_lops/1/edit").should route_to("can_bo_lops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/can_bo_lops").should route_to("can_bo_lops#create")
    end

    it "routes to #update" do
      put("/can_bo_lops/1").should route_to("can_bo_lops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/can_bo_lops/1").should route_to("can_bo_lops#destroy", :id => "1")
    end

  end
end
