class AddDiemTbktAndDiemThucHanhAndDiemChuyenCanAndDiemQuaTrinhToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_tbkt, :integer
    add_column :lop_mon_hoc_sinh_viens, :diem_thuc_hanh, :integer
    add_column :lop_mon_hoc_sinh_viens, :diem_chuyen_can, :integer
    add_column :lop_mon_hoc_sinh_viens, :diem_qua_trinh, :integer
  end
end
