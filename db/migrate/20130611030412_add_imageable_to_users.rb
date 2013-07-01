class AddImageableToUsers < ActiveRecord::Migration
  def change  
   return if PgTools.private_search_path?  	
    add_column :users, :imageable_id, :integer
    add_column :users, :imageable_type, :string
  end
end
