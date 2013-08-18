class AddLopMonHocIdToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :lop_mon_hoc_id, :integer
    add_index :lop_mon_hoc_sinh_viens, :lop_mon_hoc_id
  end
end
