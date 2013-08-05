class AddDiemChuyenCanToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_chuyen_can, :integer
  end
end
