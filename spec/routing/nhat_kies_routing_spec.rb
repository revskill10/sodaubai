require "spec_helper"

describe NhatKiesController do
  describe "routing" do

    it "routes to #index" do
      get("/nhat_kies").should route_to("nhat_kies#index")
    end

    it "routes to #new" do
      get("/nhat_kies/new").should route_to("nhat_kies#new")
    end

    it "routes to #show" do
      get("/nhat_kies/1").should route_to("nhat_kies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nhat_kies/1/edit").should route_to("nhat_kies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nhat_kies").should route_to("nhat_kies#create")
    end

    it "routes to #update" do
      put("/nhat_kies/1").should route_to("nhat_kies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nhat_kies/1").should route_to("nhat_kies#destroy", :id => "1")
    end

  end
end
