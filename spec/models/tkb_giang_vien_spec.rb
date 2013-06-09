require 'spec_helper'

describe TkbGiangVien do
  subject(:tkb_giang_vien) {create(:tkb_giang_vien)}
  its(:giang_vien) {should be_instance_of(GiangVien)}
end
