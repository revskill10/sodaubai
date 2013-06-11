require 'spec_helper'
require "cancan/matchers"
describe GiangVien do
  subject { create(:giang_vien) }
  its(:ho_ten) { should include("hoten")}
  context "user is giang vien" do
  	let(:user){ create(:user, code: "dungth")}
  	subject {create(:giang_vien, ma_giang_vien: "dungth")}
    it "giangvien be able to manage lichtrinhgiangday" do    
      lop = create(:lop_mon_hoc, giang_vien: subject)
      lich = create(:lich_trinh_giang_day, lop_mon_hoc: lop)
      user.add_role :giangvien, lop
      ability = Ability.new(user)
      ability.should be_able_to(:manage, lich)
    end
    it "giang vien should not be able to manage lichtrinhgiangday lop khac" do 
    	pending
    end
  end
end
