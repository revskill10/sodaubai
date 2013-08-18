class AddMonHocIndexFromLopMonHoc < ActiveRecord::Migration
  def change
  	add_index :lop_mon_hocs, :ma_mon_hoc
  end
end
