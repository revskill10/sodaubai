class AddPhongDangKyAndNgayDayToDangKyDayBu < ActiveRecord::Migration
  def change
    add_column :dang_ky_day_bus, :phong_dang_ky, :string
    add_column :dang_ky_day_bus, :ngay_day, :datetime
  end
end
