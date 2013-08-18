class RemoveNamHocFromLopMonHocSinhVien < ActiveRecord::Migration
  def change
  	remove_column :lop_mon_hoc_sinh_viens, :nam_hoc
  	remove_column :lop_mon_hoc_sinh_viens, :hoc_ky
  end
end
