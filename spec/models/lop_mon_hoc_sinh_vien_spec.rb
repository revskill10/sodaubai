require 'spec_helper'

describe LopMonHocSinhVien do
  subject(:lop_mon_hoc_sinh_vien) {create(:lop_mon_hoc_sinh_vien)}
  its(:sinh_vien){should respond_to("ma_sinh_vien")}
end
