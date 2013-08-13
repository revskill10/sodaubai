class AddLopMonHocIdToTkbGiangVien < ActiveRecord::Migration
  def change
    add_column :tkb_giang_viens, :lop_mon_hoc_id, :integer
    add_index :tkb_giang_viens, :lop_mon_hoc_id      
  end
end
