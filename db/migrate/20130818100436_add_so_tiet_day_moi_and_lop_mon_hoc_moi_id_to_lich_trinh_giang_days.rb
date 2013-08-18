class AddSoTietDayMoiAndLopMonHocMoiIdToLichTrinhGiangDays < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :so_tiet_day_moi, :integer
    add_column :lich_trinh_giang_days, :lop_mon_hoc_moi_id, :integer
  end
end
