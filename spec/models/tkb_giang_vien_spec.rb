require 'spec_helper'

describe TkbGiangVien do
  it "should be ok" do 
  	customer = double('customer', name: 'Aslak')
	obj = mock('object', created_at: { Time.now })
	customer.name.should == 'Aslak'
  end
end
