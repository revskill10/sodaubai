class AddTroGiangToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :ma_tro_giang, :string         
  end
end
