require 'spec_helper'

describe SinhVien do
  subject { create(:sinh_vien)}
  its(:ten) { should include("ten") }
  it "should be valid with a name" do
  	should respond_to(:ma_sinh_vien)  	
  end
end
