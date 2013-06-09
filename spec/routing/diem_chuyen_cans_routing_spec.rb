require "spec_helper"

describe DiemChuyenCansController do
  describe "routing" do

    it "routes to #index" do
      get("/diem_chuyen_cans").should route_to("diem_chuyen_cans#index")
    end

    it "routes to #new" do
      get("/diem_chuyen_cans/new").should route_to("diem_chuyen_cans#new")
    end

    it "routes to #show" do
      get("/diem_chuyen_cans/1").should route_to("diem_chuyen_cans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/diem_chuyen_cans/1/edit").should route_to("diem_chuyen_cans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/diem_chuyen_cans").should route_to("diem_chuyen_cans#create")
    end

    it "routes to #update" do
      put("/diem_chuyen_cans/1").should route_to("diem_chuyen_cans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/diem_chuyen_cans/1").should route_to("diem_chuyen_cans#destroy", :id => "1")
    end

  end
end
