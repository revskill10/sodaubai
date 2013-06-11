module ControllerMacros  
  def login_gv
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @gv = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth")
      @user = FactoryGirl.create(:user, imageable: @gv)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
    end
  end
  def login_sv
  	before(:each) do 
  		@request.env["devise.mapping"] = Devise.mappings[:user]
  		@sv = FactoryGirl.create(:sinh_vien, ma_sinh_vien: "123456")
  		@user = FactoryGirl.create(:user_sv, imageable: @sv)
  		sign_in @user
  	end
  end
end