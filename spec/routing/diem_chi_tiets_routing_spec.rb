require "spec_helper"

describe DiemChiTietsController do
  describe "routing" do

    it "routes to #index" do
      get("/diem_chi_tiets").should route_to("diem_chi_tiets#index")
    end

    it "routes to #new" do
      get("/diem_chi_tiets/new").should route_to("diem_chi_tiets#new")
    end

    it "routes to #show" do
      get("/diem_chi_tiets/1").should route_to("diem_chi_tiets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/diem_chi_tiets/1/edit").should route_to("diem_chi_tiets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/diem_chi_tiets").should route_to("diem_chi_tiets#create")
    end

    it "routes to #update" do
      put("/diem_chi_tiets/1").should route_to("diem_chi_tiets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/diem_chi_tiets/1").should route_to("diem_chi_tiets#destroy", :id => "1")
    end

  end
end
