require "spec_helper"

describe DiemDanhsController do
  describe "routing" do

    it "routes to #index" do
      get("/diem_danhs").should route_to("diem_danhs#index")
    end

    it "routes to #new" do
      get("/diem_danhs/new").should route_to("diem_danhs#new")
    end

    it "routes to #show" do
      get("/diem_danhs/1").should route_to("diem_danhs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/diem_danhs/1/edit").should route_to("diem_danhs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/diem_danhs").should route_to("diem_danhs#create")
    end

    it "routes to #update" do
      put("/diem_danhs/1").should route_to("diem_danhs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/diem_danhs/1").should route_to("diem_danhs#destroy", :id => "1")
    end

  end
end
