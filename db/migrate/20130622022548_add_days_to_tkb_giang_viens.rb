class AddDaysToTkbGiangViens < ActiveRecord::Migration
  def change  	
    add_column :tkb_giang_viens, :days, :text
  end
end
