class AddDiemThucHanhToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_thuc_hanh, :integer
  end
end
