require "spec_helper"

describe DayThaysController do
  describe "routing" do

    it "routes to #index" do
      get("/day_thays").should route_to("day_thays#index")
    end

    it "routes to #new" do
      get("/day_thays/new").should route_to("day_thays#new")
    end

    it "routes to #show" do
      get("/day_thays/1").should route_to("day_thays#show", :id => "1")
    end

    it "routes to #edit" do
      get("/day_thays/1/edit").should route_to("day_thays#edit", :id => "1")
    end

    it "routes to #create" do
      post("/day_thays").should route_to("day_thays#create")
    end

    it "routes to #update" do
      put("/day_thays/1").should route_to("day_thays#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/day_thays/1").should route_to("day_thays#destroy", :id => "1")
    end

  end
end
