module ControllerMacros  
  def login_gv
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @gv = FactoryGirl.create(:giang_vien, ma_giang_vien: "dungth")
      @sv = FactoryGirl.create(:sinh_vien, ma_sinh_vien: "123456")
      @sv2 = FactoryGirl.create(:sinh_vien, ma_sinh_vien: "1234567")
      @lops = create_list(:lop_mon_hoc, 5, giang_vien: @gv)
      @enrolls = create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: @lops[0], sinh_vien: @sv)   
      @enrolls = create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: @lops[1], sinh_vien: @sv2)   
      @user = FactoryGirl.create(:user, imageable: @gv)

      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
    end
  end
  def login_sv
  	before(:each) do 
  		@request.env["devise.mapping"] = Devise.mappings[:user]
  		@sv = FactoryGirl.create(:sinh_vien, ma_sinh_vien: "123456")
      @lops = create_list(:lop_mon_hoc, 5, giang_vien: @gv)
      @lops.each do |lop|        
        @enrolls = create_list(:lop_mon_hoc_sinh_vien, 5, lop_mon_hoc: lop, sinh_vien: @sv)
      end
  		@user = FactoryGirl.create(:user_sv, imageable: @sv)
  		sign_in @user
  	end
  end
end