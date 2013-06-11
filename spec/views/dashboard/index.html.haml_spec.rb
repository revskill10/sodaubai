require 'spec_helper'

describe "dashboard/index.html.haml" do
  it "display all lop mon hocs" do 
  	assign(:current_lops, [
  		stub_model(LopMonHoc, ma_giang_vien:"dungth", ma_lop:"lop1"),
  		stub_model(LopMonHoc, ma_giang_vien:"dungth", ma_lop:"lop2")
  		])
	render
	rendered.should contain("lop1")
	rendered.should contain("lop2")
  end
end
