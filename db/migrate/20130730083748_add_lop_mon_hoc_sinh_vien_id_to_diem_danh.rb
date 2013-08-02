class AddLopMonHocSinhVienIdToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :lop_mon_hoc_sinh_vien_id, :integer
  end
end
