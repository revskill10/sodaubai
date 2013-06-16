require 'spec_helper'

describe "the signin process" do
  include RequestHelpers
 
  	let(:authed_user) { create_logged_in_user }
    before { login_as(authed_user, scope: :user) }
 
  it "should allow access" do
    visit dashboard_index_path
    page.should have_content("Welcome")
    # should be good!
  end
  it "access lop mon hoc 1" do 
  	visit '/lop_mon_hocs/1'
  	page.should have_content("Xin chao")
  end
end