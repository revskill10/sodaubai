require "spec_helper"

describe KienNghisController do
  describe "routing" do

    it "routes to #index" do
      get("/kien_nghis").should route_to("kien_nghis#index")
    end

    it "routes to #new" do
      get("/kien_nghis/new").should route_to("kien_nghis#new")
    end

    it "routes to #show" do
      get("/kien_nghis/1").should route_to("kien_nghis#show", :id => "1")
    end

    it "routes to #edit" do
      get("/kien_nghis/1/edit").should route_to("kien_nghis#edit", :id => "1")
    end

    it "routes to #create" do
      post("/kien_nghis").should route_to("kien_nghis#create")
    end

    it "routes to #update" do
      put("/kien_nghis/1").should route_to("kien_nghis#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/kien_nghis/1").should route_to("kien_nghis#destroy", :id => "1")
    end

  end
end
