class AddStatusToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :status, :boolean
  end
end
