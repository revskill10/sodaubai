require 'spec_helper'

describe DashboardController do  
  context "Khach dang nhap" do 
  	pending
  end
  context "Can bo Dao Tao dang nhap" do 
  	pending
  end
  context "GiangVien dang nhap" do   	  
	  login_gv
	  before(:each) do 
	  	@lops = create_list(:lop_mon_hoc, 5, giang_vien: @gv)
	  end	 
	  it "should get danh sach lop mon hocs" do
	    # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
	    # the valid_session overrides the devise login. Remove the valid_session from your specs
	    get 'index'
	    assigns(:current_lops).should have(5).records	    
	  end	   
  end
  context "SinhVien dang nhap" do 
  	login_sv
  	before(:each) do   		
  		@gv = create(:giang_vien, ma_giang_vien: "gv1")
	  	@lops = create_list(:lop_mon_hoc, 7, giang_vien: @gv)
	  	7.times do |i|
	  		@dks = create(:lop_mon_hoc_sinh_vien, sinh_vien: @sv, lop_mon_hoc: @lops[i])
	  	end
	  end	
  	
  	it "should get index" do
	    # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
	    # the valid_session overrides the devise login. Remove the valid_session from your specs
	    
	    get 'index'
	    assigns(:current_lops).should have(7).records
	  end
  end
end
