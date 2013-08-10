class AddMaLopHcToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :ma_lop_hc, :string
  end
end
