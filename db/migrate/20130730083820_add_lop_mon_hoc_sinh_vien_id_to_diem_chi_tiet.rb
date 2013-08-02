class AddLopMonHocSinhVienIdToDiemChiTiet < ActiveRecord::Migration
  def change
    add_column :diem_chi_tiets, :lop_mon_hoc_sinh_vien_id, :integer
  end
end
