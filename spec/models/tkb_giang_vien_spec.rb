require 'spec_helper'
require 'date'
describe TkbGiangVien do
  subject(:tkb_giang_vien) {create(:tkb_giang_vien)}
  its(:giang_vien) {should be_instance_of(GiangVien)}
  it "should orccur on 02-04-2013" do 
  	subject.schedule.occurs_on?(Date.new(2013,4,2)).should be_true
  end
end
