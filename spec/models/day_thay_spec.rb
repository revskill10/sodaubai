require 'spec_helper'

describe DayThay do
  it "should pass" do 
  	dt = create(:day_thay)
  	dt.nam_hoc.should == "2012-2013"
  end
end
