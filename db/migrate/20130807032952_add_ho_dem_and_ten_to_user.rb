class AddHoDemAndTenToUser < ActiveRecord::Migration
  def change  	
    add_column :users, :ho_dem, :string
    add_column :users, :ten, :string
  end
end
