class ChangeTypeForSoTietBoSung < ActiveRecord::Migration
  def up
  	change_column :lop_mon_hocs, :so_tiet_bo_sung, :decimal
  end

  def down
  	change_column :lop_mon_hocs, :so_tiet_bo_sung, :integer
  end
end
