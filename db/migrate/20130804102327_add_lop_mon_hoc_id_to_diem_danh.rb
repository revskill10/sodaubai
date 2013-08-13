class AddLopMonHocIdToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :lop_mon_hoc_id, :integer
    add_index :diem_danhs, :lop_mon_hoc_id
  end
end
