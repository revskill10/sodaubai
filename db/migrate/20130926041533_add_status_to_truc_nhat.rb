class AddStatusToTrucNhat < ActiveRecord::Migration
  def change
    add_column :truc_nhats, :status, :boolean
    add_index :truc_nhats, :status
  end
end
