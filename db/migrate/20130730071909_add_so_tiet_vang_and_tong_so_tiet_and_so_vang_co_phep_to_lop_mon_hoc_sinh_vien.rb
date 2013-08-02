class AddSoTietVangAndTongSoTietAndSoVangCoPhepToLopMonHocSinhVien < ActiveRecord::Migration
  def change
    add_column :lop_mon_hoc_sinh_viens, :so_tiet_vang, :integer
    add_column :lop_mon_hoc_sinh_viens, :tong_so_tiet, :integer
    add_column :lop_mon_hoc_sinh_viens, :so_vang_co_phep, :integer
  end
end
