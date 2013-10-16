class AddDiemGocTbktToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :diem_goc_tbkt, :decimal
  end
end
