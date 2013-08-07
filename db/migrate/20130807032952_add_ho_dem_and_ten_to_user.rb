class AddHoDemAndTenToUser < ActiveRecord::Migration
  def change
  	return if PgTools.private_search_path?
    add_column :users, :ho_dem, :string
    add_column :users, :ten, :string
  end
end
