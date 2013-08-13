class AddLopMonHocIdToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :lop_mon_hoc_id, :integer
    add_index :lich_trinh_giang_days, :lop_mon_hoc_id      
  end
end
