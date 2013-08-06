class CreateUsersGroups < ActiveRecord::Migration
  def change
  	return if PgTools.private_search_path?
    create_table :users_groups do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
