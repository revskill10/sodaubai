require 'spec_helper'
require 'pp'
describe "the signin process" do
  include RequestHelpers
 
	let(:authed_user) { create_logged_in_user }

  before { 
    
    
  	login_as(authed_user, scope: :user)
  }
   
  it "access lop mon hoc 1" do 
  	#authed_user.code.should == "dungth"
  	#authed_user.reload.imageable.ma_giang_vien.should == "dungth"
   # authed_user.reload.imageable.tkb_giang_viens.should have(3).records
  	visit "/lop_mon_hocs/1"
   
 page.should have_content("Tuan")
  end

end