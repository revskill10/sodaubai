class AddRoleToUsers < ActiveRecord::Migration
  def change
  	return if PgTools.private_search_path?
    add_column :users, :role, :string
  end
end
