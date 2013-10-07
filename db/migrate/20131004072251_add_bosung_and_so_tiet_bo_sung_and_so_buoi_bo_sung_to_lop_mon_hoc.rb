class AddBosungAndSoTietBoSungAndSoBuoiBoSungToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :bosung, :boolean
    add_column :lop_mon_hocs, :so_tiet_bo_sung, :integer
    add_column :lop_mon_hocs, :so_buoi_bo_sung, :integer
  end
end
