class AddDiemTbktToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_tbkt, :integer
  end
end
