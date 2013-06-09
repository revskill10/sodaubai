require 'spec_helper'

describe LopMonHoc do
  
  subject (:lop_mon_hoc) {create(:lop_mon_hoc)}

  its(:nam_hoc) {should include("2012")}
  its(:giang_vien) {should respond_to("ma_giang_vien")}

end
