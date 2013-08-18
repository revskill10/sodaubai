class AddLichTrinhIndexToDiemDanh < ActiveRecord::Migration
  def change
  	add_index :diem_danhs, :lich_trinh_giang_day_id
  end
end
