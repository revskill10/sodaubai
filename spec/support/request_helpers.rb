require 'spec_helper'
module ApplicationRspecHelpers
  def stub_user
    @user = double('user')
    @user.stub(:id => 100)
    @user.stub(:fullname => "ABC")
    view.stub(:user_signed_in? => true)
    view.stub(:current_user => @user)
  end
  
end