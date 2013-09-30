class AddUserIdToLichViPham < ActiveRecord::Migration
  def change
    add_column :lich_vi_phams, :user_id, :integer
    add_index :lich_vi_phams, :user_id
  end
end
