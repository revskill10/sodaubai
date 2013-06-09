require "spec_helper"

describe GiangViensController do
  describe "routing" do

    it "routes to #index" do
      get("/giang_viens").should route_to("giang_viens#index")
    end

    it "routes to #new" do
      get("/giang_viens/new").should route_to("giang_viens#new")
    end

    it "routes to #show" do
      get("/giang_viens/1").should route_to("giang_viens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/giang_viens/1/edit").should route_to("giang_viens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/giang_viens").should route_to("giang_viens#create")
    end

    it "routes to #update" do
      put("/giang_viens/1").should route_to("giang_viens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/giang_viens/1").should route_to("giang_viens#destroy", :id => "1")
    end

  end
end
