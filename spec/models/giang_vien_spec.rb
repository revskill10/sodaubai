require 'spec_helper'
require "cancan/matchers"
describe GiangVien do
  subject { create(:giang_vien) }  
  its(:ho_ten) { should include("hoten")}
  
  context "user is giang vien" do
  	let(:user){ create(:user, code: "dungth")}
  	subject {create(:giang_vien, ma_giang_vien: "dungth")}
  	let(:lops) {create_list(:lop_mon_hoc, 10, giang_vien: subject)}
  	
    it "giangvien be able to manage lichtrinhgiangday" do  
      subject.reload do |gv|  
      	  gv.lop_mon_hocs.should have(10).records
	      lop = gv.lop_mon_hocs.first
	      lich = create(:lich_trinh_giang_day, lop_mon_hoc: lop)
	      user.add_role :giangvien, lop
	      ability = Ability.new(user)
	      ability.should be_able_to(:manage, lich)
	      ability.should_not be_able_to(:manage, :all)
	  end
    end
    it "giangvien should not be able to manage lichtrinhgiangday of other classes" do     
    	gv2 = create(:giang_vien)
      	lop = create(:lop_mon_hoc, giang_vien: gv2)            	      	
      	lich = create(:lich_trinh_giang_day, lop_mon_hoc: lop)
      	ability = Ability.new(user)
      	ability.should_not be_able_to(:manage, lich)      
    end    
  end
end
