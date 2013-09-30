class AddUserIdToLichTrucNhat < ActiveRecord::Migration
  def change
    add_column :lich_truc_nhats, :user_id, :integer
    add_index :lich_truc_nhats, :user_id
  end
end
