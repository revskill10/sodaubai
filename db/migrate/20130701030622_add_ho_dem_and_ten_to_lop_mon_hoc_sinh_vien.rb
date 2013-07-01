class AddHoDemAndTenToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :ho_dem, :string
    add_column :lop_mon_hoc_sinh_viens, :ten, :string
  end
end
