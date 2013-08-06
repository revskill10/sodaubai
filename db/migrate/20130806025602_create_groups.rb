class CreateGroups < ActiveRecord::Migration
  def change
  	return if PgTools.private_search_path?
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
