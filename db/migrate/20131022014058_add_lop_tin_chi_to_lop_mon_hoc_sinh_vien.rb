class AddLopTinChiToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :lop_tin_chi, :boolean
  end
end
