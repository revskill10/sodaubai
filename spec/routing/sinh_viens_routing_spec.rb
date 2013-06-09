require "spec_helper"

describe SinhViensController do
  describe "routing" do

    it "routes to #index" do
      get("/sinh_viens").should route_to("sinh_viens#index")
    end

    it "routes to #new" do
      get("/sinh_viens/new").should route_to("sinh_viens#new")
    end

    it "routes to #show" do
      get("/sinh_viens/1").should route_to("sinh_viens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sinh_viens/1/edit").should route_to("sinh_viens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sinh_viens").should route_to("sinh_viens#create")
    end

    it "routes to #update" do
      put("/sinh_viens/1").should route_to("sinh_viens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sinh_viens/1").should route_to("sinh_viens#destroy", :id => "1")
    end

  end
end
