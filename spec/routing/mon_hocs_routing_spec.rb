require "spec_helper"

describe MonHocsController do
  describe "routing" do

    it "routes to #index" do
      get("/mon_hocs").should route_to("mon_hocs#index")
    end

    it "routes to #new" do
      get("/mon_hocs/new").should route_to("mon_hocs#new")
    end

    it "routes to #show" do
      get("/mon_hocs/1").should route_to("mon_hocs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mon_hocs/1/edit").should route_to("mon_hocs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mon_hocs").should route_to("mon_hocs#create")
    end

    it "routes to #update" do
      put("/mon_hocs/1").should route_to("mon_hocs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mon_hocs/1").should route_to("mon_hocs#destroy", :id => "1")
    end

  end
end
