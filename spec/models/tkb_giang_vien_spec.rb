require 'spec_helper'
require 'date'
describe TkbGiangVien do
  subject(:tkb_giang_vien) {create(:tkb_giang_vien, ngay_bat_dau: "2013-02-09", ngay_ket_thuc: "2013-06-09")}
 
  its(:ngay_bat_dau) { should == Date.new(2013,2,9)}
  it "should have 17 sessions" do 
  	subject.schedule.all_occurrences.count.should == 17
  	Rails.logger.debug subject.schedule.all_occurrences.inspect
  	
  end 
end
