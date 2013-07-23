class AddGroupDiemToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :group_diem, :text
  end
end
