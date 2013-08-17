class ChangeTypeForDiemThuongXuyen < ActiveRecord::Migration
  def up
  	change_column :lop_mon_hoc_sinh_viens, :lan1, :decimal
  	change_column :lop_mon_hoc_sinh_viens, :lan2, :decimal
  	change_column :lop_mon_hoc_sinh_viens, :lan3, :decimal
  	change_column :lop_mon_hoc_sinh_viens, :lan4, :decimal
  	change_column :lop_mon_hoc_sinh_viens, :lan5, :decimal
  	change_column :lop_mon_hoc_sinh_viens, :diem_thuc_hanh, :decimal
  end

  def down
  	change_column :lop_mon_hoc_sinh_viens, :lan1, :integer
  	change_column :lop_mon_hoc_sinh_viens, :lan2, :integer
  	change_column :lop_mon_hoc_sinh_viens, :lan3, :integer
  	change_column :lop_mon_hoc_sinh_viens, :lan4, :integer
  	change_column :lop_mon_hoc_sinh_viens, :lan5, :integer
  	change_column :lop_mon_hoc_sinh_viens, :diem_thuc_hanh, :integer
  end
end
