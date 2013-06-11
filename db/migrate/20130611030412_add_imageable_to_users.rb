class AddImageableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :imageable_id, :integer
    add_column :users, :imageable_type, :string
  end
end
