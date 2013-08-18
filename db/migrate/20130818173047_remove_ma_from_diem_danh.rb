class RemoveMaFromDiemDanh < ActiveRecord::Migration
  def change  	  	
  	remove_column :lich_trinh_giang_days, :siso
  	remove_column :lich_trinh_giang_days, :sv
  end
end
