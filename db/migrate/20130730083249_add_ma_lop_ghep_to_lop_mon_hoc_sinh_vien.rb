class AddMaLopGhepToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :ma_lop_ghep, :string
  end
end
