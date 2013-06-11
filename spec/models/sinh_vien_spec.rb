require 'spec_helper'

describe SinhVien do

  subject { create(:sinh_vien, ma_sinh_vien: "123")}
  its(:ten) { should include("ten") }
  it "should be valid with a name" do
  	user = create(:user, code: "123", username: "test")
  	subject.reload do |s|
  		s.user.username.should == "test"
  	end
  end
end
