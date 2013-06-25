class AddTenMonHocAndMaLopHanhChinhToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :ten_mon_hoc, :string
    add_column :lop_mon_hoc_sinh_viens, :ma_lop_hanh_chinh, :string
  end
end
