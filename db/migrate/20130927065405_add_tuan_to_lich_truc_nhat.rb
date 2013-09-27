class AddTuanToLichTrucNhat < ActiveRecord::Migration
  def change
    add_column :lich_truc_nhats, :tuan, :integer
  end
end
