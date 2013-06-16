require 'spec_helper'
require 'pp'
describe "the signin process" do
  include RequestHelpers
 
	let(:authed_user) { create_logged_in_user }
  before { login_as(authed_user, scope: :user) }
   
  it "access lop mon hoc 1" do 
  	visit dashboard_index_path
   
  	page.should have_content("/lop_mon_hocs/1")

  
  end
end