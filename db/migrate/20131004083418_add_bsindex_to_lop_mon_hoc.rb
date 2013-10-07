class AddBsindexToLopMonHoc < ActiveRecord::Migration
  def change
  	add_index :lop_mon_hocs, :da_duyet_bo_sung
  end
end
