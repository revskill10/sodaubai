class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :posts_count
      t.integer :lop_mon_hoc_id
      t.integer :user_id
      t.boolean :locked

      t.timestamps
    end
    add_index :topics, :lop_mon_hoc_id      
  end
end
