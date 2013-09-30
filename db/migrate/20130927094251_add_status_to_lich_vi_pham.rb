class AddStatusToLichViPham < ActiveRecord::Migration
  def change
    add_column :lich_vi_phams, :status, :boolean
  end
end
