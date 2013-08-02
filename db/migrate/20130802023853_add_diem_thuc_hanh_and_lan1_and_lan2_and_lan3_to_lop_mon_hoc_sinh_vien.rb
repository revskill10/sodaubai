class AddDiemThucHanhAndLan1AndLan2AndLan3ToLopMonHocSinhVien < ActiveRecord::Migration
  def change    
    add_column :lop_mon_hoc_sinh_viens, :lan1, :integer
    add_column :lop_mon_hoc_sinh_viens, :lan2, :integer
    add_column :lop_mon_hoc_sinh_viens, :lan3, :integer
  end
end
