require 'spec_helper'

describe GiangVien do
  subject { create(:giang_vien) }
  its(:ho_ten) { should include("hoten")}
end
