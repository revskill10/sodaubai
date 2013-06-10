require 'spec_helper'

describe LichTrinhGiangDay do
  let(:lop_mon_hoc){ create(:lop_mon_hoc)}
  subject(:lich_trinh_giang_day) {create(:lich_trinh_giang_day, lop_mon_hoc: lop_mon_hoc, ngay_day: Time.now, so_tiet_day: 2, noi_dung_day: "Test")}

  it { should be_valid}
end
