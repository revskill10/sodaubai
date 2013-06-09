require "spec_helper"

describe LopMonHocSinhViensController do
  describe "routing" do

    it "routes to #index" do
      get("/lop_mon_hoc_sinh_viens").should route_to("lop_mon_hoc_sinh_viens#index")
    end

    it "routes to #new" do
      get("/lop_mon_hoc_sinh_viens/new").should route_to("lop_mon_hoc_sinh_viens#new")
    end

    it "routes to #show" do
      get("/lop_mon_hoc_sinh_viens/1").should route_to("lop_mon_hoc_sinh_viens#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lop_mon_hoc_sinh_viens/1/edit").should route_to("lop_mon_hoc_sinh_viens#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lop_mon_hoc_sinh_viens").should route_to("lop_mon_hoc_sinh_viens#create")
    end

    it "routes to #update" do
      put("/lop_mon_hoc_sinh_viens/1").should route_to("lop_mon_hoc_sinh_viens#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lop_mon_hoc_sinh_viens/1").should route_to("lop_mon_hoc_sinh_viens#destroy", :id => "1")
    end

  end
end
