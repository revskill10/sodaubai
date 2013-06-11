require 'spec_helper'

describe User do
  
  context "la sinh vien" do 
  	let(:sinh_vien){ create(:sinh_vien, ma_sinh_vien:"12345" )}
  	subject {create(:user, username: "revskill09@gmail.com", imageable: sinh_vien)}
  	its(:imageable) {should be_instance_of(SinhVien) }
  	its("imageable.ma_sinh_vien") {should == "12345" }
  	it "should have role normal" do 
  		subject.has_role?(:normal).should be_true
  	end
  	it "sinh vien should have user info" do   		
  		sinh_vien.reload do |sv|
  			sv.user.should_not be_nil
  			sv.user.username.should == "revskill09@gmail.com"
  			sv.user.code.should == "12345"
  		end
  	end
  end

  context "la giang vien" do 
  	let(:giang_vien){ create(:giang_vien, ma_giang_vien:"dungth" )}
  	subject {create(:user, username: "dungth@hpu.edu.vn", imageable: giang_vien)}
  	its(:imageable) {should be_instance_of(GiangVien)}
  	its("username") {should == "dungth@hpu.edu.vn"}
  	its("imageable.ma_giang_vien"){ should == "dungth"}
  	it "giang vien should have user info" do 
  		giang_vien.reload do |gv|
  			gv.user.should_not be_nil
  			gv.user.username.should == "dungth@hpu.edu.vn"
  			gv.user.code.should == "dungth"
  		end
  	end
  end

  context "la can bo" do  
  	subject {create(:user, username: "revskill09@gmail.com")}
  	its(:imageable) { should be_nil}
  end

end
