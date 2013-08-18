class AddLichTrinhGiangDayIdToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :lich_trinh_giang_day_id, :integer
  end
end
