class AddDiemQuaTrinhAndNoteToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_qua_trinh, :integer
    add_column :lop_mon_hoc_sinh_viens, :note, :string
  end
end
