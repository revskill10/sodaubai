class ChangeLopGhepFromLopMonHocSinhVien < ActiveRecord::Migration
  def up
  	add_column :lop_mon_hoc_sinh_viens, :lop_ghep, :boolean
  end
  def down
  	remove_column :lop_mon_hoc_sinh_viens, :lop_ghep
  end
end
