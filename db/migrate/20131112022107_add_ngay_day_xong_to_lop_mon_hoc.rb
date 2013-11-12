class AddNgayDayXongToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :ngay_day_xong, :datetime
  end
end
