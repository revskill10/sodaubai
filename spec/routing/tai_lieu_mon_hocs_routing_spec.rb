require "spec_helper"

describe TaiLieuMonHocsController do
  describe "routing" do

    it "routes to #index" do
      get("/tai_lieu_mon_hocs").should route_to("tai_lieu_mon_hocs#index")
    end

    it "routes to #new" do
      get("/tai_lieu_mon_hocs/new").should route_to("tai_lieu_mon_hocs#new")
    end

    it "routes to #show" do
      get("/tai_lieu_mon_hocs/1").should route_to("tai_lieu_mon_hocs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tai_lieu_mon_hocs/1/edit").should route_to("tai_lieu_mon_hocs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tai_lieu_mon_hocs").should route_to("tai_lieu_mon_hocs#create")
    end

    it "routes to #update" do
      put("/tai_lieu_mon_hocs/1").should route_to("tai_lieu_mon_hocs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tai_lieu_mon_hocs/1").should route_to("tai_lieu_mon_hocs#destroy", :id => "1")
    end

  end
end
