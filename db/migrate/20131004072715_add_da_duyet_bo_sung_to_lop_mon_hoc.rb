class AddDaDuyetBoSungToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :da_duyet_bo_sung, :boolean
  end
end
