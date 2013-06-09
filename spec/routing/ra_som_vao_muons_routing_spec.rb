require "spec_helper"

describe RaSomVaoMuonsController do
  describe "routing" do

    it "routes to #index" do
      get("/ra_som_vao_muons").should route_to("ra_som_vao_muons#index")
    end

    it "routes to #new" do
      get("/ra_som_vao_muons/new").should route_to("ra_som_vao_muons#new")
    end

    it "routes to #show" do
      get("/ra_som_vao_muons/1").should route_to("ra_som_vao_muons#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ra_som_vao_muons/1/edit").should route_to("ra_som_vao_muons#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ra_som_vao_muons").should route_to("ra_som_vao_muons#create")
    end

    it "routes to #update" do
      put("/ra_som_vao_muons/1").should route_to("ra_som_vao_muons#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ra_som_vao_muons/1").should route_to("ra_som_vao_muons#destroy", :id => "1")
    end

  end
end
