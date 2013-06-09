require "spec_helper"

describe TkbGiangViensController do
  describe "routing" do

    it "routes to #index" do
      get("/tkb_giang_viens").should route_to("tkb_giang_viens#index")
    end

    it "routes to #new" do
      get("/tkb_giang_viens/new").should route_to("tkb_giang_viens#new")
    end

    it "routes to #show" do
      get("/tkb_giang_viens/1").should route_to("tkb_giang_viens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tkb_giang_viens/1/edit").should route_to("tkb_giang_viens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tkb_giang_viens").should route_to("tkb_giang_viens#create")
    end

    it "routes to #update" do
      put("/tkb_giang_viens/1").should route_to("tkb_giang_viens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tkb_giang_viens/1").should route_to("tkb_giang_viens#destroy", :id => "1")
    end

  end
end
