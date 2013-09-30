class AddIndexToLichViPham < ActiveRecord::Migration
  def change
  	add_index :lich_vi_phams, :lenmuon
  	add_index :lich_vi_phams, :vesom
  	add_index :lich_vi_phams, :bogio  	  	
  end
end
