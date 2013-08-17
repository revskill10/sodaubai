class RenameMaLopHcFromLopMonHocSinhVien < ActiveRecord::Migration
  def change
    remove_column :lop_mon_hoc_sinh_viens, :ma_lop_hc
    add_column :lop_mon_hoc_sinh_viens, :tin_chi, :boolean
  end
end
