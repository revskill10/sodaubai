class AddSoTietPhanBoToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :so_tiet_phan_bo, :decimal
  end
end
