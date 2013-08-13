class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :lop_mon_hoc_id
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, [:lop_mon_hoc_id, :topic_id]
  end
end
