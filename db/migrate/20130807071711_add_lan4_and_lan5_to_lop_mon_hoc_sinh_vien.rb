class AddLan4AndLan5ToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :lan4, :integer
    add_column :lop_mon_hoc_sinh_viens, :lan5, :integer
  end
end
