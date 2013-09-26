class AddIndexToTrucNhat < ActiveRecord::Migration
  def change
  	add_index :truc_nhats, :lich_truc_nhat_id
  	add_index :truc_nhats, :ma_sinh_vien
  	add_index :lich_truc_nhats, :lop_mon_hoc_id
  end
end
