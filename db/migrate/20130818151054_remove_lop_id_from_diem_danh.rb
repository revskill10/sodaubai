class RemoveLopIdFromDiemDanh < ActiveRecord::Migration
  def change
  	remove_column :diem_danhs, :lop_mon_hoc_id
  end
end
