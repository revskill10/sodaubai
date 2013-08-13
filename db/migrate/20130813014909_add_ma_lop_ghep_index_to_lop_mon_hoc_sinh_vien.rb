class AddMaLopGhepIndexToLopMonHocSinhVien < ActiveRecord::Migration
  def change
      add_index :lop_mon_hoc_sinh_viens, [:ma_lop_ghep, :ma_mon_hoc]
  end
end
