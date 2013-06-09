require "spec_helper"

describe ThongBaoLopHocsController do
  describe "routing" do

    it "routes to #index" do
      get("/thong_bao_lop_hocs").should route_to("thong_bao_lop_hocs#index")
    end

    it "routes to #new" do
      get("/thong_bao_lop_hocs/new").should route_to("thong_bao_lop_hocs#new")
    end

    it "routes to #show" do
      get("/thong_bao_lop_hocs/1").should route_to("thong_bao_lop_hocs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/thong_bao_lop_hocs/1/edit").should route_to("thong_bao_lop_hocs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/thong_bao_lop_hocs").should route_to("thong_bao_lop_hocs#create")
    end

    it "routes to #update" do
      put("/thong_bao_lop_hocs/1").should route_to("thong_bao_lop_hocs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/thong_bao_lop_hocs/1").should route_to("thong_bao_lop_hocs#destroy", :id => "1")
    end

  end
end
