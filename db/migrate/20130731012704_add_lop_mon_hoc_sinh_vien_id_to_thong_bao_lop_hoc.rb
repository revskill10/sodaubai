class AddLopMonHocSinhVienIdToThongBaoLopHoc < ActiveRecord::Migration
  def change
    add_column :thong_bao_lop_hocs, :lop_mon_hoc_sinh_vien_id, :integer
  end
end
