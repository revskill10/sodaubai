class AddLopMonHocSinhVienIdToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :lop_mon_hoc_sinh_vien_id, :integer
  end
end
