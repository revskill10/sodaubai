class AddNgaySinhToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :ngay_sinh, :datetime
  end
end
