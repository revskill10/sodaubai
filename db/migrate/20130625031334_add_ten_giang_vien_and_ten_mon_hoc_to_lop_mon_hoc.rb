class AddTenGiangVienAndTenMonHocToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :ten_giang_vien, :string
    add_column :lop_mon_hocs, :ten_mon_hoc, :string
  end
end
