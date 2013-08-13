class AddGroupIdToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :group_id, :integer
    add_index :lop_mon_hoc_sinh_viens, :group_id      
  end
end
