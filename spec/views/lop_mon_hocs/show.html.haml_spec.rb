require 'spec_helper'

describe "lop_mon_hocs/show" do
  before(:each) do
    @gv = create(:giang_vien, ma_giang_vien: "dungth")
    @current_user = create(:user, code: "dungth", imageable: @gv)
    @lop_mon_hoc = create(:lop_mon_hoc, ma_lop: "lop1", giang_vien: @gv)
    @sv = create(:sinh_vien, ten: "test", ma_sinh_vien: "123456")
    @usv = create(:user, code: "123456", username: "revskill09@gmail.com")
    @enroll = create(:lop_mon_hoc_sinh_vien, lop_mon_hoc: @lop_mon_hoc, sinh_vien: @sv)
    #@lop_mon_hoc.reload
#    @current_sinhviens = @lop_mon_hoc.sinh_viens
  end
  it "sinh vien co user" do 
    @sv.reload do |s|
      s.username.should == "revskill09@gmail.com"
    end
  end
  it "lop can co sinh vien" do 
    @lop_mon_hoc.reload do |lop|
      lop.sinh_viens.should have(1).record
      lop.sinh_viens.first.should_not be_nil
      lop.sinh_viens.first.username.should == "revskill09@gmail.com"
    end
  end
  it "hien thi danh sach ssinh vien cua lop" do
    @lop_mon_hoc.reload do 
      render
      # Run the generator again with the --webrat flag if you want to use webrat matchers
      rendered.should contain("lop1")
      rendered.should contain("revskill09")
    end
  end
end
